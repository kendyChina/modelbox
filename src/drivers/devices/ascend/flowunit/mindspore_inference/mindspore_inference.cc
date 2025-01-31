/*
 * Copyright 2021 The Modelbox Project Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "mindspore_inference.h"

#include <cstdint>
#include <map>

#include "include/api/context.h"
#include "include/api/model.h"
#include "include/api/serialization.h"
#include "model_decrypt.h"
#include "modelbox/base/status.h"

static std::map<std::string, mindspore::ModelType> model_type_map{
    {"mindir", mindspore::ModelType::kMindIR},
    {"air", mindspore::ModelType::kAIR},
    {"om", mindspore::ModelType::kOM},
    {"onnx", mindspore::ModelType::kONNX}};

static std::map<mindspore::DataType, std::string> data_type_map{
    {mindspore::DataType::kNumberTypeFloat32, "float"},
    {mindspore::DataType::kNumberTypeFloat16, "float16"},
    {mindspore::DataType::kNumberTypeFloat64, "float64"},
    {mindspore::DataType::kNumberTypeInt8, "int8"},
    {mindspore::DataType::kNumberTypeInt32, "int"},
    {mindspore::DataType::kNumberTypeInt16, "int16"},
    {mindspore::DataType::kNumberTypeInt64, "int64"},
    {mindspore::DataType::kNumberTypeUInt8, "uint8"},
    {mindspore::DataType::kNumberTypeUInt16, "uint16"},
    {mindspore::DataType::kNumberTypeUInt32, "uint32"},
    {mindspore::DataType::kNumberTypeUInt64, "uint64"},
    {mindspore::DataType::kNumberTypeBool, "bool"},
    {mindspore::DataType::kObjectTypeString, "str"}};

static std::map<mindspore::DataType, modelbox::ModelBoxDataType>
    data_type_flow_map{
        {mindspore::DataType::kNumberTypeFloat32, modelbox::MODELBOX_FLOAT},
        {mindspore::DataType::kNumberTypeFloat16, modelbox::MODELBOX_HALF},
        {mindspore::DataType::kNumberTypeFloat64, modelbox::MODELBOX_DOUBLE},
        {mindspore::DataType::kNumberTypeInt8, modelbox::MODELBOX_INT8},
        {mindspore::DataType::kNumberTypeInt32, modelbox::MODELBOX_INT32},
        {mindspore::DataType::kNumberTypeInt16, modelbox::MODELBOX_INT16},
        {mindspore::DataType::kNumberTypeInt64, modelbox::MODELBOX_INT64},
        {mindspore::DataType::kNumberTypeUInt8, modelbox::MODELBOX_UINT8},
        {mindspore::DataType::kNumberTypeUInt16, modelbox::MODELBOX_UINT16},
        {mindspore::DataType::kNumberTypeUInt32, modelbox::MODELBOX_UINT32},
        {mindspore::DataType::kNumberTypeUInt64, modelbox::MODELBOX_UINT64},
        {mindspore::DataType::kObjectTypeString, modelbox::MODELBOX_STRING},
        {mindspore::DataType::kNumberTypeBool, modelbox::MODELBOX_BOOL}};

MindSporeInference::~MindSporeInference() {
  model_ = nullptr;
  context_ = nullptr;
}

modelbox::Status MindSporeInference::GetModelType(
    const std::string &model_entry, mindspore::ModelType &model_type) {
  auto type_vec = modelbox::StringSplit(model_entry, '.');
  if (type_vec.size() == 0) {
    return {modelbox::STATUS_BADCONF, "model entry format is not suitable."};
  }

  auto iter = model_type_map.find(type_vec.back());
  if (iter == model_type_map.end()) {
    model_type = mindspore::ModelType::kUnknownType;
    return {modelbox::STATUS_BADCONF, ""};
  }

  model_type = model_type_map[type_vec.back()];
  return modelbox::STATUS_OK;
}

modelbox::Status MindSporeInference::CheckMindSporeInfo(
    const std::vector<mindspore::MSTensor> &tensor_list,
    const std::vector<std::string> &name_list,
    const std::vector<std::string> &type_list) {
  if (tensor_list.size() != name_list.size() ||
      tensor_list.size() != type_list.size()) {
    auto err_msg = "model input size " + std::to_string(tensor_list.size()) +
                   " does not match for config file input name or type size " +
                   std::to_string(name_list.size());
    MBLOG_ERROR << err_msg;
    return {modelbox::STATUS_BADCONF, err_msg};
  }

  for (size_t i = 0; i < tensor_list.size(); ++i) {
    std::string name(tensor_list[i].Name());
    if (name != name_list[i]) {
      auto err_msg = "model input name " + name +
                     " does not match for config file input name " +
                     name_list[i];
      MBLOG_ERROR << err_msg;
      return {modelbox::STATUS_BADCONF, err_msg};
    }

    auto type = tensor_list[i].DataType();
    if (data_type_map[type] != type_list[i]) {
      auto err_msg = "model input name " + data_type_map[type] +
                     " does not match for config file input name " +
                     type_list[i];
      MBLOG_ERROR << err_msg;
      return {modelbox::STATUS_BADCONF, err_msg};
    }
  }

  return modelbox::STATUS_OK;
}

modelbox::Status MindSporeInference::CheckMindSporeIO(
    const std::vector<std::string> &input_name_list,
    const std::vector<std::string> &output_name_list,
    const std::vector<std::string> &input_type_list,
    const std::vector<std::string> &output_type_list) {
  auto input_tensor = model_->GetInputs();
  auto ret = CheckMindSporeInfo(input_tensor, input_name_list, input_type_list);
  if (ret != modelbox::STATUS_OK) {
    auto err_msg = "check ms input failed " + ret.WrapErrormsgs();
    MBLOG_ERROR << err_msg;
    return {modelbox::STATUS_BADCONF, err_msg};
  }

  auto output_tensor = model_->GetOutputs();
  ret = CheckMindSporeInfo(output_tensor, output_name_list, output_type_list);
  if (ret != modelbox::STATUS_OK) {
    auto err_msg = "check ms output failed " + ret.WrapErrormsgs();
    MBLOG_ERROR << err_msg;
    return {modelbox::STATUS_BADCONF, err_msg};
  }

  return modelbox::STATUS_OK;
}

void MindSporeInference::InitContext(
    std::shared_ptr<modelbox::Configuration> &config) {
  context_ = std::make_shared<mindspore::Context>();
  auto ascend310_info = std::make_shared<mindspore::Ascend310DeviceInfo>();
  auto device_id = config->GetInt32("deviceid", 0);
  // NCHW or NHWC
  auto input_format = config->GetString("input_format", "NCHW");
  ascend310_info->SetDeviceID(device_id);
  ascend310_info->SetInputFormat(input_format);
  auto &device_list = context_->MutableDeviceInfo();
  device_list.push_back(ascend310_info);
}

modelbox::Status MindSporeInference::Init(
    const std::string &model_entry,
    std::shared_ptr<modelbox::Configuration> &config,
    const std::vector<std::string> &input_name_list,
    const std::vector<std::string> &output_name_list,
    const std::vector<std::string> &input_type_list,
    const std::vector<std::string> &output_type_list,
    const std::shared_ptr<modelbox::Drivers> &drivers_ptr) {
  InitContext(config);

  mindspore::ModelType mindspore_type;
  auto ret = GetModelType(model_entry, mindspore_type);
  if (ret != modelbox::STATUS_OK) {
    auto err_msg = "get model type failed " + ret.WrapErrormsgs();
    MBLOG_ERROR << err_msg;
    return {modelbox::STATUS_BADCONF, err_msg};
  }

  mindspore::Graph graph(nullptr);
  mindspore::Status ms_status{mindspore::kSuccess};
  ModelDecryption model_decrypt;
  if (modelbox::STATUS_SUCCESS !=
      model_decrypt.Init(model_entry, drivers_ptr, config)) {
    return {modelbox::STATUS_FAULT, "init model fail"};
  }

  if (model_decrypt.GetModelState() == ModelDecryption::MODEL_STATE_ENCRYPT) {
    int64_t model_len = 0;
    std::shared_ptr<uint8_t> modelBuf =
        model_decrypt.GetModelSharedBuffer(model_len);
    if (!modelBuf) {
      return {modelbox::STATUS_FAULT, "Decrypt model fail"};
    }
    ms_status = mindspore::Serialization::Load(
        (const void *)modelBuf.get(), (size_t)model_len, mindspore_type, &graph);
  } else if (model_decrypt.GetModelState() ==
             ModelDecryption::MODEL_STATE_PLAIN) {
    ms_status = mindspore::Serialization::Load(model_entry.c_str(),
                                                mindspore_type, &graph);
  }
  if (ms_status != mindspore::kSuccess) {
    auto err_msg = "mindspore load model failed, path " + model_entry + ", msg: " + ms_status.GetErrDescription();
    MBLOG_ERROR << err_msg;
    return {modelbox::STATUS_FAULT, err_msg};
  }

  model_ = std::make_shared<mindspore::Model>();
  ms_status =
      model_->Build(mindspore::GraphCell(graph), context_);
  if (ms_status != mindspore::kSuccess) {
    auto err_msg = "build model failed: " + ms_status.GetErrDescription();
    MBLOG_ERROR << err_msg;
    return {modelbox::STATUS_FAULT, err_msg};
  }

  ret = CheckMindSporeIO(input_name_list, output_name_list, input_type_list,
                         output_type_list);
  if (ret != modelbox::STATUS_OK) {
    auto err_msg = "input or output info got error, " + ret.WrapErrormsgs();
    MBLOG_ERROR << err_msg;
    return {modelbox::STATUS_BADCONF, err_msg};
  }

  auto size = model_->GetInputs()[0].Shape()[0];
  if (size <= 0) {
    auto err_msg = "model input batch_size less than zero";
    MBLOG_ERROR << err_msg;
    return {modelbox::STATUS_FAULT, err_msg};
  }

  batch_size_ = size;
  return modelbox::STATUS_OK;
}

modelbox::Status MindSporeInference::Infer(
    std::shared_ptr<modelbox::DataContext> data_ctx) {
  auto input_tensor = model_->GetInputs();
  std::vector<mindspore::MSTensor> ms_inputs;
  for (size_t i = 0; i < input_tensor.size(); ++i) {
    auto name = input_tensor[i].Name();
    auto input_buffer_list = data_ctx->Input(name);
    MBLOG_DEBUG << "input_buffer_list: " << name
                << ", size: " << input_buffer_list->Size();
    ms_inputs.emplace_back(
        name, input_tensor[i].DataType(), input_tensor[i].Shape(),
        input_buffer_list->ConstData(), input_buffer_list->GetBytes());
    MBLOG_DEBUG << "input_tensor[i].Shape(): " << input_tensor[i].Shape()[0]
                << ", " << input_tensor[i].Shape()[1];
    MBLOG_DEBUG << "input_tensor[i].DataSize(): " << input_tensor[i].DataSize();
    MBLOG_DEBUG << "input_tensor[i].ElementNum(): "
                << input_tensor[i].ElementNum();
  }

  std::vector<mindspore::MSTensor> ms_outputs;
  auto ret = model_->Predict(ms_inputs, &ms_outputs);
  if (ret != mindspore::kSuccess) {
    auto err_msg = "mindspore inference failed, ret " +
                   std::to_string(ret.StatusCode()) +
                   " err_msg: " + ret.ToString();
    MBLOG_ERROR << err_msg;
    return {modelbox::STATUS_FAULT, err_msg};
  }

  auto output_tensor = model_->GetOutputs();
  for (size_t i = 0; i < output_tensor.size(); ++i) {
    auto output_buffer_list = data_ctx->Output(output_tensor[i].Name());
    MBLOG_DEBUG << "output_tensor[i].DataSize(): "
                << output_tensor[i].DataSize() << ", "
                << "output_tensor[i].ElementNum(): "
                << output_tensor[i].ElementNum();
    if (output_tensor[i].Shape()[0] == 0) {
      auto err_msg =
          "output_tensor " + output_tensor[i].Name() + " first dim is zero";
      MBLOG_ERROR << err_msg;
      return {modelbox::STATUS_FAULT, err_msg};
    }

    std::vector<size_t> shape_size(
        output_tensor[i].Shape()[0],
        output_tensor[i].DataSize() / output_tensor[i].Shape()[0]);
    auto status = output_buffer_list->BuildFromHost(
        shape_size, output_tensor[i].MutableData(),
        output_tensor[i].DataSize());
    if (status != modelbox::STATUS_OK) {
      auto err_msg =
          "output buffer list build from host failed " + status.WrapErrormsgs();
      MBLOG_ERROR << err_msg;
      return {modelbox::STATUS_FAULT, err_msg};
    }

    output_buffer_list->Set("shape", output_tensor[i].Shape());
    MBLOG_DEBUG << "output shape: ";
    for (auto &item : output_tensor[i].Shape()) {
      MBLOG_DEBUG << item;
    }
    output_buffer_list->Set("type",
                            data_type_flow_map[output_tensor[i].DataType()]);
  }

  return modelbox::STATUS_OK;
}
