шЎ
ю
:
Add
x"T
y"T
z"T"
Ttype:
2	
A
AddV2
x"T
y"T
z"T"
Ttype:
2	

ApplyGradientDescent
var"T

alpha"T

delta"T
out"T" 
Ttype:
2	"
use_lockingbool( 
x
Assign
ref"T

value"T

output_ref"T"	
Ttype"
validate_shapebool("
use_lockingbool(
R
BroadcastGradientArgs
s0"T
s1"T
r0"T
r1"T"
Ttype0:
2	
8
Const
output"dtype"
valuetensor"
dtypetype
S
DynamicStitch
indices*N
data"T*N
merged"T"
Nint(0"	
Ttype
^
Fill
dims"
index_type

value"T
output"T"	
Ttype"

index_typetype0:
2	
?
FloorDiv
x"T
y"T
z"T"
Ttype:
2	
9
FloorMod
x"T
y"T
z"T"
Ttype:

2	
=
Greater
x"T
y"T
z
"
Ttype:
2	
.
Identity

input"T
output"T"	
Ttype
,
Log
x"T
y"T"
Ttype:

2
8
Maximum
x"T
y"T
z"T"
Ttype:

2	
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(
=
Mul
x"T
y"T
z"T"
Ttype:
2	
.
Neg
x"T
y"T"
Ttype:

2	

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
X
PlaceholderWithDefault
input"dtype
output"dtype"
dtypetype"
shapeshape
6
Pow
x"T
y"T
z"T"
Ttype:

2	
a
Range
start"Tidx
limit"Tidx
delta"Tidx
output"Tidx"
Tidxtype0:	
2	
)
Rank

input"T

output"	
Ttype
>
RealDiv
x"T
y"T
z"T"
Ttype:
2	
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
?
Select
	condition

t"T
e"T
output"T"	
Ttype
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
H
ShardedFilename
basename	
shard

num_shards
filename
O
Size

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
:
Sub
x"T
y"T
z"T"
Ttype:
2	

Sum

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
c
Tile

input"T
	multiples"
Tmultiples
output"T"	
Ttype"

Tmultiplestype0:
2	
s

VariableV2
ref"dtype"
shapeshape"
dtypetype"
	containerstring "
shared_namestring 
&
	ZerosLike
x"T
y"T"	
Ttype"serve*1.15.02v1.15.0-rc3-22-g590d6eeи
J
inputPlaceholder*
shape:*
dtype0*
_output_shapes
:
P
PlaceholderPlaceholder*
dtype0*
_output_shapes
:*
shape:
Y
weight/initial_valueConst*
_output_shapes
: *
dtype0*
valueB
 *Веx>
j
weight
VariableV2*
_output_shapes
: *
dtype0*
shape: *
	container *
shared_name 

weight/AssignAssignweightweight/initial_value*
T0*
use_locking(*
_output_shapes
: *
validate_shape(*
_class
loc:@weight
[
weight/readIdentityweight*
T0*
_output_shapes
: *
_class
loc:@weight
W
bias/initial_valueConst*
valueB
 *nМm?*
dtype0*
_output_shapes
: 
h
bias
VariableV2*
dtype0*
_output_shapes
: *
shared_name *
	container *
shape: 

bias/AssignAssignbiasbias/initial_value*
_output_shapes
: *
_class
	loc:@bias*
validate_shape(*
T0*
use_locking(
U
	bias/readIdentitybias*
T0*
_class
	loc:@bias*
_output_shapes
: 
A
MulMulinputweight/read*
T0*
_output_shapes
:
@
outputAddMul	bias/read*
T0*
_output_shapes
:
B
subSuboutputPlaceholder*
_output_shapes
:*
T0
J
Pow/yConst*
_output_shapes
: *
valueB
 *   @*
dtype0
9
PowPowsubPow/y*
T0*
_output_shapes
:
2
RankRankPow*
T0*
_output_shapes
: 
M
range/startConst*
value	B : *
dtype0*
_output_shapes
: 
M
range/deltaConst*
dtype0*
value	B :*
_output_shapes
: 
_
rangeRangerange/startRankrange/delta*

Tidx0*#
_output_shapes
:џџџџџџџџџ
T
SumSumPowrange*
_output_shapes
: *

Tidx0*
	keep_dims( *
T0
N
	truediv/yConst*
_output_shapes
: *
dtype0*
valueB
 *  B
C
truedivRealDivSum	truediv/y*
_output_shapes
: *
T0
R
gradients/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
X
gradients/grad_ys_0Const*
_output_shapes
: *
valueB
 *  ?*
dtype0
o
gradients/FillFillgradients/Shapegradients/grad_ys_0*
_output_shapes
: *
T0*

index_type0
_
gradients/truediv_grad/ShapeConst*
dtype0*
_output_shapes
: *
valueB 
a
gradients/truediv_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
Р
,gradients/truediv_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/truediv_grad/Shapegradients/truediv_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
e
gradients/truediv_grad/RealDivRealDivgradients/Fill	truediv/y*
T0*
_output_shapes
: 
­
gradients/truediv_grad/SumSumgradients/truediv_grad/RealDiv,gradients/truediv_grad/BroadcastGradientArgs*

Tidx0*
_output_shapes
: *
T0*
	keep_dims( 

gradients/truediv_grad/ReshapeReshapegradients/truediv_grad/Sumgradients/truediv_grad/Shape*
Tshape0*
_output_shapes
: *
T0
G
gradients/truediv_grad/NegNegSum*
T0*
_output_shapes
: 
s
 gradients/truediv_grad/RealDiv_1RealDivgradients/truediv_grad/Neg	truediv/y*
T0*
_output_shapes
: 
y
 gradients/truediv_grad/RealDiv_2RealDiv gradients/truediv_grad/RealDiv_1	truediv/y*
_output_shapes
: *
T0
t
gradients/truediv_grad/mulMulgradients/Fill gradients/truediv_grad/RealDiv_2*
T0*
_output_shapes
: 
­
gradients/truediv_grad/Sum_1Sumgradients/truediv_grad/mul.gradients/truediv_grad/BroadcastGradientArgs:1*
_output_shapes
: *

Tidx0*
T0*
	keep_dims( 

 gradients/truediv_grad/Reshape_1Reshapegradients/truediv_grad/Sum_1gradients/truediv_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
s
'gradients/truediv_grad/tuple/group_depsNoOp^gradients/truediv_grad/Reshape!^gradients/truediv_grad/Reshape_1
й
/gradients/truediv_grad/tuple/control_dependencyIdentitygradients/truediv_grad/Reshape(^gradients/truediv_grad/tuple/group_deps*1
_class'
%#loc:@gradients/truediv_grad/Reshape*
_output_shapes
: *
T0
п
1gradients/truediv_grad/tuple/control_dependency_1Identity gradients/truediv_grad/Reshape_1(^gradients/truediv_grad/tuple/group_deps*3
_class)
'%loc:@gradients/truediv_grad/Reshape_1*
_output_shapes
: *
T0
d
gradients/Sum_grad/ShapeShapePow*#
_output_shapes
:џџџџџџџџџ*
T0*
out_type0

gradients/Sum_grad/SizeSizegradients/Sum_grad/Shape*
T0*
_output_shapes
: *
out_type0*+
_class!
loc:@gradients/Sum_grad/Shape

gradients/Sum_grad/addAddV2rangegradients/Sum_grad/Size*#
_output_shapes
:џџџџџџџџџ*
T0*+
_class!
loc:@gradients/Sum_grad/Shape
Ў
gradients/Sum_grad/modFloorModgradients/Sum_grad/addgradients/Sum_grad/Size*#
_output_shapes
:џџџџџџџџџ*+
_class!
loc:@gradients/Sum_grad/Shape*
T0

gradients/Sum_grad/Shape_1Shapegradients/Sum_grad/mod*+
_class!
loc:@gradients/Sum_grad/Shape*
_output_shapes
:*
out_type0*
T0

gradients/Sum_grad/range/startConst*
dtype0*+
_class!
loc:@gradients/Sum_grad/Shape*
value	B : *
_output_shapes
: 

gradients/Sum_grad/range/deltaConst*
value	B :*+
_class!
loc:@gradients/Sum_grad/Shape*
dtype0*
_output_shapes
: 
и
gradients/Sum_grad/rangeRangegradients/Sum_grad/range/startgradients/Sum_grad/Sizegradients/Sum_grad/range/delta*+
_class!
loc:@gradients/Sum_grad/Shape*#
_output_shapes
:џџџџџџџџџ*

Tidx0

gradients/Sum_grad/Fill/valueConst*
value	B :*
_output_shapes
: *+
_class!
loc:@gradients/Sum_grad/Shape*
dtype0
Ч
gradients/Sum_grad/FillFillgradients/Sum_grad/Shape_1gradients/Sum_grad/Fill/value*+
_class!
loc:@gradients/Sum_grad/Shape*

index_type0*#
_output_shapes
:џџџџџџџџџ*
T0
њ
 gradients/Sum_grad/DynamicStitchDynamicStitchgradients/Sum_grad/rangegradients/Sum_grad/modgradients/Sum_grad/Shapegradients/Sum_grad/Fill*
N*#
_output_shapes
:џџџџџџџџџ*
T0*+
_class!
loc:@gradients/Sum_grad/Shape

gradients/Sum_grad/Maximum/yConst*
value	B :*
dtype0*+
_class!
loc:@gradients/Sum_grad/Shape*
_output_shapes
: 
Р
gradients/Sum_grad/MaximumMaximum gradients/Sum_grad/DynamicStitchgradients/Sum_grad/Maximum/y*#
_output_shapes
:џџџџџџџџџ*
T0*+
_class!
loc:@gradients/Sum_grad/Shape
И
gradients/Sum_grad/floordivFloorDivgradients/Sum_grad/Shapegradients/Sum_grad/Maximum*
T0*#
_output_shapes
:џџџџџџџџџ*+
_class!
loc:@gradients/Sum_grad/Shape
Љ
gradients/Sum_grad/ReshapeReshape/gradients/truediv_grad/tuple/control_dependency gradients/Sum_grad/DynamicStitch*
Tshape0*
_output_shapes
:*
T0

gradients/Sum_grad/TileTilegradients/Sum_grad/Reshapegradients/Sum_grad/floordiv*
T0*

Tmultiples0*
_output_shapes
:
d
gradients/Pow_grad/ShapeShapesub*
T0*
out_type0*#
_output_shapes
:џџџџџџџџџ
]
gradients/Pow_grad/Shape_1ShapePow/y*
out_type0*
T0*
_output_shapes
: 
Д
(gradients/Pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/Pow_grad/Shapegradients/Pow_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
`
gradients/Pow_grad/mulMulgradients/Sum_grad/TilePow/y*
T0*
_output_shapes
:
]
gradients/Pow_grad/sub/yConst*
dtype0*
_output_shapes
: *
valueB
 *  ?
_
gradients/Pow_grad/subSubPow/ygradients/Pow_grad/sub/y*
T0*
_output_shapes
: 
]
gradients/Pow_grad/PowPowsubgradients/Pow_grad/sub*
T0*
_output_shapes
:
r
gradients/Pow_grad/mul_1Mulgradients/Pow_grad/mulgradients/Pow_grad/Pow*
_output_shapes
:*
T0
Ё
gradients/Pow_grad/SumSumgradients/Pow_grad/mul_1(gradients/Pow_grad/BroadcastGradientArgs*

Tidx0*
_output_shapes
:*
T0*
	keep_dims( 

gradients/Pow_grad/ReshapeReshapegradients/Pow_grad/Sumgradients/Pow_grad/Shape*
Tshape0*
_output_shapes
:*
T0
a
gradients/Pow_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 
k
gradients/Pow_grad/GreaterGreatersubgradients/Pow_grad/Greater/y*
_output_shapes
:*
T0
n
"gradients/Pow_grad/ones_like/ShapeShapesub*
T0*
out_type0*#
_output_shapes
:џџџџџџџџџ
g
"gradients/Pow_grad/ones_like/ConstConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
Ё
gradients/Pow_grad/ones_likeFill"gradients/Pow_grad/ones_like/Shape"gradients/Pow_grad/ones_like/Const*
T0*

index_type0*
_output_shapes
:

gradients/Pow_grad/SelectSelectgradients/Pow_grad/Greatersubgradients/Pow_grad/ones_like*
T0*
_output_shapes
:
[
gradients/Pow_grad/LogLoggradients/Pow_grad/Select*
T0*
_output_shapes
:
R
gradients/Pow_grad/zeros_like	ZerosLikesub*
T0*
_output_shapes
:

gradients/Pow_grad/Select_1Selectgradients/Pow_grad/Greatergradients/Pow_grad/Loggradients/Pow_grad/zeros_like*
_output_shapes
:*
T0
`
gradients/Pow_grad/mul_2Mulgradients/Sum_grad/TilePow*
_output_shapes
:*
T0
y
gradients/Pow_grad/mul_3Mulgradients/Pow_grad/mul_2gradients/Pow_grad/Select_1*
T0*
_output_shapes
:
Ѕ
gradients/Pow_grad/Sum_1Sumgradients/Pow_grad/mul_3*gradients/Pow_grad/BroadcastGradientArgs:1*

Tidx0*
_output_shapes
:*
	keep_dims( *
T0

gradients/Pow_grad/Reshape_1Reshapegradients/Pow_grad/Sum_1gradients/Pow_grad/Shape_1*
Tshape0*
T0*
_output_shapes
: 
g
#gradients/Pow_grad/tuple/group_depsNoOp^gradients/Pow_grad/Reshape^gradients/Pow_grad/Reshape_1
Ы
+gradients/Pow_grad/tuple/control_dependencyIdentitygradients/Pow_grad/Reshape$^gradients/Pow_grad/tuple/group_deps*
_output_shapes
:*
T0*-
_class#
!loc:@gradients/Pow_grad/Reshape
Я
-gradients/Pow_grad/tuple/control_dependency_1Identitygradients/Pow_grad/Reshape_1$^gradients/Pow_grad/tuple/group_deps*/
_class%
#!loc:@gradients/Pow_grad/Reshape_1*
T0*
_output_shapes
: 
g
gradients/sub_grad/ShapeShapeoutput*
out_type0*
T0*#
_output_shapes
:џџџџџџџџџ
n
gradients/sub_grad/Shape_1ShapePlaceholder*
T0*
out_type0*#
_output_shapes
:џџџџџџџџџ
Д
(gradients/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/sub_grad/Shapegradients/sub_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Д
gradients/sub_grad/SumSum+gradients/Pow_grad/tuple/control_dependency(gradients/sub_grad/BroadcastGradientArgs*

Tidx0*
_output_shapes
:*
T0*
	keep_dims( 

gradients/sub_grad/ReshapeReshapegradients/sub_grad/Sumgradients/sub_grad/Shape*
_output_shapes
:*
T0*
Tshape0
m
gradients/sub_grad/NegNeg+gradients/Pow_grad/tuple/control_dependency*
T0*
_output_shapes
:
Ѓ
gradients/sub_grad/Sum_1Sumgradients/sub_grad/Neg*gradients/sub_grad/BroadcastGradientArgs:1*

Tidx0*
	keep_dims( *
T0*
_output_shapes
:

gradients/sub_grad/Reshape_1Reshapegradients/sub_grad/Sum_1gradients/sub_grad/Shape_1*
_output_shapes
:*
Tshape0*
T0
g
#gradients/sub_grad/tuple/group_depsNoOp^gradients/sub_grad/Reshape^gradients/sub_grad/Reshape_1
Ы
+gradients/sub_grad/tuple/control_dependencyIdentitygradients/sub_grad/Reshape$^gradients/sub_grad/tuple/group_deps*
T0*-
_class#
!loc:@gradients/sub_grad/Reshape*
_output_shapes
:
б
-gradients/sub_grad/tuple/control_dependency_1Identitygradients/sub_grad/Reshape_1$^gradients/sub_grad/tuple/group_deps*/
_class%
#!loc:@gradients/sub_grad/Reshape_1*
_output_shapes
:*
T0
g
gradients/output_grad/ShapeShapeMul*
out_type0*#
_output_shapes
:џџџџџџџџџ*
T0
d
gradients/output_grad/Shape_1Shape	bias/read*
out_type0*
_output_shapes
: *
T0
Н
+gradients/output_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/output_grad/Shapegradients/output_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
К
gradients/output_grad/SumSum+gradients/sub_grad/tuple/control_dependency+gradients/output_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0

gradients/output_grad/ReshapeReshapegradients/output_grad/Sumgradients/output_grad/Shape*
Tshape0*
T0*
_output_shapes
:
О
gradients/output_grad/Sum_1Sum+gradients/sub_grad/tuple/control_dependency-gradients/output_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0

gradients/output_grad/Reshape_1Reshapegradients/output_grad/Sum_1gradients/output_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
p
&gradients/output_grad/tuple/group_depsNoOp^gradients/output_grad/Reshape ^gradients/output_grad/Reshape_1
з
.gradients/output_grad/tuple/control_dependencyIdentitygradients/output_grad/Reshape'^gradients/output_grad/tuple/group_deps*0
_class&
$"loc:@gradients/output_grad/Reshape*
T0*
_output_shapes
:
л
0gradients/output_grad/tuple/control_dependency_1Identitygradients/output_grad/Reshape_1'^gradients/output_grad/tuple/group_deps*2
_class(
&$loc:@gradients/output_grad/Reshape_1*
T0*
_output_shapes
: 
f
gradients/Mul_grad/ShapeShapeinput*#
_output_shapes
:џџџџџџџџџ*
out_type0*
T0
c
gradients/Mul_grad/Shape_1Shapeweight/read*
out_type0*
_output_shapes
: *
T0
Д
(gradients/Mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/Mul_grad/Shapegradients/Mul_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
}
gradients/Mul_grad/MulMul.gradients/output_grad/tuple/control_dependencyweight/read*
_output_shapes
:*
T0

gradients/Mul_grad/SumSumgradients/Mul_grad/Mul(gradients/Mul_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0

gradients/Mul_grad/ReshapeReshapegradients/Mul_grad/Sumgradients/Mul_grad/Shape*
Tshape0*
T0*
_output_shapes
:
y
gradients/Mul_grad/Mul_1Mulinput.gradients/output_grad/tuple/control_dependency*
T0*
_output_shapes
:
Ѕ
gradients/Mul_grad/Sum_1Sumgradients/Mul_grad/Mul_1*gradients/Mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
T0*

Tidx0*
	keep_dims( 

gradients/Mul_grad/Reshape_1Reshapegradients/Mul_grad/Sum_1gradients/Mul_grad/Shape_1*
Tshape0*
T0*
_output_shapes
: 
g
#gradients/Mul_grad/tuple/group_depsNoOp^gradients/Mul_grad/Reshape^gradients/Mul_grad/Reshape_1
Ы
+gradients/Mul_grad/tuple/control_dependencyIdentitygradients/Mul_grad/Reshape$^gradients/Mul_grad/tuple/group_deps*-
_class#
!loc:@gradients/Mul_grad/Reshape*
_output_shapes
:*
T0
Я
-gradients/Mul_grad/tuple/control_dependency_1Identitygradients/Mul_grad/Reshape_1$^gradients/Mul_grad/tuple/group_deps*
T0*
_output_shapes
: */
_class%
#!loc:@gradients/Mul_grad/Reshape_1
b
GradientDescent/learning_rateConst*
_output_shapes
: *
valueB
 *
з#<*
dtype0
я
2GradientDescent/update_weight/ApplyGradientDescentApplyGradientDescentweightGradientDescent/learning_rate-gradients/Mul_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class
loc:@weight*
_output_shapes
: 
ь
0GradientDescent/update_bias/ApplyGradientDescentApplyGradientDescentbiasGradientDescent/learning_rate0gradients/output_grad/tuple/control_dependency_1*
_class
	loc:@bias*
_output_shapes
: *
T0*
use_locking( 

GradientDescentNoOp1^GradientDescent/update_bias/ApplyGradientDescent3^GradientDescent/update_weight/ApplyGradientDescent
*
initNoOp^bias/Assign^weight/Assign
Y
save/filename/inputConst*
dtype0*
_output_shapes
: *
valueB Bmodel
n
save/filenamePlaceholderWithDefaultsave/filename/input*
shape: *
dtype0*
_output_shapes
: 
e

save/ConstPlaceholderWithDefaultsave/filename*
shape: *
_output_shapes
: *
dtype0

save/StringJoin/inputs_1Const*
_output_shapes
: *<
value3B1 B+_temp_749e501b425d4efd8c4be4c9f9b21b4e/part*
dtype0
u
save/StringJoin
StringJoin
save/Constsave/StringJoin/inputs_1*
_output_shapes
: *
N*
	separator 
Q
save/num_shardsConst*
value	B :*
_output_shapes
: *
dtype0
k
save/ShardedFilename/shardConst"/device:CPU:0*
value	B : *
dtype0*
_output_shapes
: 

save/ShardedFilenameShardedFilenamesave/StringJoinsave/ShardedFilename/shardsave/num_shards"/device:CPU:0*
_output_shapes
: 
|
save/SaveV2/tensor_namesConst"/device:CPU:0*
dtype0*!
valueBBbiasBweight*
_output_shapes
:
v
save/SaveV2/shape_and_slicesConst"/device:CPU:0*
dtype0*
_output_shapes
:*
valueBB B 

save/SaveV2SaveV2save/ShardedFilenamesave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesbiasweight"/device:CPU:0*
dtypes
2
 
save/control_dependencyIdentitysave/ShardedFilename^save/SaveV2"/device:CPU:0*
T0*'
_class
loc:@save/ShardedFilename*
_output_shapes
: 
Ќ
+save/MergeV2Checkpoints/checkpoint_prefixesPacksave/ShardedFilename^save/control_dependency"/device:CPU:0*
T0*
N*
_output_shapes
:*

axis 

save/MergeV2CheckpointsMergeV2Checkpoints+save/MergeV2Checkpoints/checkpoint_prefixes
save/Const"/device:CPU:0*
delete_old_dirs(

save/IdentityIdentity
save/Const^save/MergeV2Checkpoints^save/control_dependency"/device:CPU:0*
_output_shapes
: *
T0

save/RestoreV2/tensor_namesConst"/device:CPU:0*!
valueBBbiasBweight*
dtype0*
_output_shapes
:
y
save/RestoreV2/shape_and_slicesConst"/device:CPU:0*
dtype0*
valueBB B *
_output_shapes
:
Є
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*
dtypes
2*
_output_shapes

::

save/AssignAssignbiassave/RestoreV2*
validate_shape(*
use_locking(*
_output_shapes
: *
_class
	loc:@bias*
T0

save/Assign_1Assignweightsave/RestoreV2:1*
_class
loc:@weight*
use_locking(*
T0*
_output_shapes
: *
validate_shape(
8
save/restore_shardNoOp^save/Assign^save/Assign_1
-
save/restore_allNoOp^save/restore_shard"<
save/Const:0save/Identity:0save/restore_all (5 @F8"
trainable_variables
B
weight:0weight/Assignweight/read:02weight/initial_value:08
:
bias:0bias/Assignbias/read:02bias/initial_value:08"
train_op

GradientDescent"
	variables
B
weight:0weight/Assignweight/read:02weight/initial_value:08
:
bias:0bias/Assignbias/read:02bias/initial_value:08*]
predictR

input
input:0
output
output:0tensorflow/serving/predict