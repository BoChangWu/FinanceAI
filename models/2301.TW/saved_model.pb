��
��
^
AssignVariableOp
resource
value"dtype"
dtypetype"
validate_shapebool( �
~
BiasAdd

value"T	
bias"T
output"T" 
Ttype:
2	"-
data_formatstringNHWC:
NHWCNCHW
h
ConcatV2
values"T*N
axis"Tidx
output"T"
Nint(0"	
Ttype"
Tidxtype0:
2	
8
Const
output"dtype"
valuetensor"
dtypetype
�
GatherV2
params"Tparams
indices"Tindices
axis"Taxis
output"Tparams"

batch_dimsint "
Tparamstype"
Tindicestype:
2	"
Taxistype:
2	
.
Identity

input"T
output"T"	
Ttype
q
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2	
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(�
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
�
Prod

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
@
ReadVariableOp
resource
value"dtype"
dtypetype�
E
Relu
features"T
activations"T"
Ttype:
2	
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
list(type)(0�
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0�
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
�
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring ��
@
StaticRegexFullMatch	
input

output
"
patternstring
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
P
	Transpose
x"T
perm"Tperm
y"T"	
Ttype"
Tpermtype0:
2	
�
VarHandleOp
resource"
	containerstring "
shared_namestring "
dtypetype"
shapeshape"#
allowed_deviceslist(string)
 �"serve*2.8.02v2.8.0-rc1-32-g3f878cff5b68��
z
dense_15/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:* 
shared_namedense_15/kernel
s
#dense_15/kernel/Read/ReadVariableOpReadVariableOpdense_15/kernel*
_output_shapes

:*
dtype0
r
dense_15/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_namedense_15/bias
k
!dense_15/bias/Read/ReadVariableOpReadVariableOpdense_15/bias*
_output_shapes
:*
dtype0
z
dense_16/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:* 
shared_namedense_16/kernel
s
#dense_16/kernel/Read/ReadVariableOpReadVariableOpdense_16/kernel*
_output_shapes

:*
dtype0
r
dense_16/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_namedense_16/bias
k
!dense_16/bias/Read/ReadVariableOpReadVariableOpdense_16/bias*
_output_shapes
:*
dtype0
z
dense_17/kernelVarHandleOp*
_output_shapes
: *
dtype0*
shape
:* 
shared_namedense_17/kernel
s
#dense_17/kernel/Read/ReadVariableOpReadVariableOpdense_17/kernel*
_output_shapes

:*
dtype0
r
dense_17/biasVarHandleOp*
_output_shapes
: *
dtype0*
shape:*
shared_namedense_17/bias
k
!dense_17/bias/Read/ReadVariableOpReadVariableOpdense_17/bias*
_output_shapes
:*
dtype0
l
RMSprop/iterVarHandleOp*
_output_shapes
: *
dtype0	*
shape: *
shared_nameRMSprop/iter
e
 RMSprop/iter/Read/ReadVariableOpReadVariableOpRMSprop/iter*
_output_shapes
: *
dtype0	
n
RMSprop/decayVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nameRMSprop/decay
g
!RMSprop/decay/Read/ReadVariableOpReadVariableOpRMSprop/decay*
_output_shapes
: *
dtype0
~
RMSprop/learning_rateVarHandleOp*
_output_shapes
: *
dtype0*
shape: *&
shared_nameRMSprop/learning_rate
w
)RMSprop/learning_rate/Read/ReadVariableOpReadVariableOpRMSprop/learning_rate*
_output_shapes
: *
dtype0
t
RMSprop/momentumVarHandleOp*
_output_shapes
: *
dtype0*
shape: *!
shared_nameRMSprop/momentum
m
$RMSprop/momentum/Read/ReadVariableOpReadVariableOpRMSprop/momentum*
_output_shapes
: *
dtype0
j
RMSprop/rhoVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nameRMSprop/rho
c
RMSprop/rho/Read/ReadVariableOpReadVariableOpRMSprop/rho*
_output_shapes
: *
dtype0
^
totalVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_nametotal
W
total/Read/ReadVariableOpReadVariableOptotal*
_output_shapes
: *
dtype0
^
countVarHandleOp*
_output_shapes
: *
dtype0*
shape: *
shared_namecount
W
count/Read/ReadVariableOpReadVariableOpcount*
_output_shapes
: *
dtype0
�
RMSprop/dense_15/kernel/rmsVarHandleOp*
_output_shapes
: *
dtype0*
shape
:*,
shared_nameRMSprop/dense_15/kernel/rms
�
/RMSprop/dense_15/kernel/rms/Read/ReadVariableOpReadVariableOpRMSprop/dense_15/kernel/rms*
_output_shapes

:*
dtype0
�
RMSprop/dense_15/bias/rmsVarHandleOp*
_output_shapes
: *
dtype0*
shape:**
shared_nameRMSprop/dense_15/bias/rms
�
-RMSprop/dense_15/bias/rms/Read/ReadVariableOpReadVariableOpRMSprop/dense_15/bias/rms*
_output_shapes
:*
dtype0
�
RMSprop/dense_16/kernel/rmsVarHandleOp*
_output_shapes
: *
dtype0*
shape
:*,
shared_nameRMSprop/dense_16/kernel/rms
�
/RMSprop/dense_16/kernel/rms/Read/ReadVariableOpReadVariableOpRMSprop/dense_16/kernel/rms*
_output_shapes

:*
dtype0
�
RMSprop/dense_16/bias/rmsVarHandleOp*
_output_shapes
: *
dtype0*
shape:**
shared_nameRMSprop/dense_16/bias/rms
�
-RMSprop/dense_16/bias/rms/Read/ReadVariableOpReadVariableOpRMSprop/dense_16/bias/rms*
_output_shapes
:*
dtype0
�
RMSprop/dense_17/kernel/rmsVarHandleOp*
_output_shapes
: *
dtype0*
shape
:*,
shared_nameRMSprop/dense_17/kernel/rms
�
/RMSprop/dense_17/kernel/rms/Read/ReadVariableOpReadVariableOpRMSprop/dense_17/kernel/rms*
_output_shapes

:*
dtype0
�
RMSprop/dense_17/bias/rmsVarHandleOp*
_output_shapes
: *
dtype0*
shape:**
shared_nameRMSprop/dense_17/bias/rms
�
-RMSprop/dense_17/bias/rms/Read/ReadVariableOpReadVariableOpRMSprop/dense_17/bias/rms*
_output_shapes
:*
dtype0

NoOpNoOp
�$
ConstConst"/device:CPU:0*
_output_shapes
: *
dtype0*�$
value�$B�$ B�$
�
layer_with_weights-0
layer-0
layer_with_weights-1
layer-1
layer_with_weights-2
layer-2
	optimizer
	variables
trainable_variables
regularization_losses
	keras_api
	__call__
*
&call_and_return_all_conditional_losses
_default_save_signature

signatures*
�

kernel
bias
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses*
�

kernel
bias
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses*
�

kernel
bias
	variables
 trainable_variables
!regularization_losses
"	keras_api
#__call__
*$&call_and_return_all_conditional_losses*
�
%iter
	&decay
'learning_rate
(momentum
)rho	rmsD	rmsE	rmsF	rmsG	rmsH	rmsI*
.
0
1
2
3
4
5*
.
0
1
2
3
4
5*
* 
�
*non_trainable_variables

+layers
,metrics
-layer_regularization_losses
.layer_metrics
	variables
trainable_variables
regularization_losses
	__call__
_default_save_signature
*
&call_and_return_all_conditional_losses
&
"call_and_return_conditional_losses*
* 
* 
* 

/serving_default* 
_Y
VARIABLE_VALUEdense_15/kernel6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUE*
[U
VARIABLE_VALUEdense_15/bias4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUE*

0
1*

0
1*
* 
�
0non_trainable_variables

1layers
2metrics
3layer_regularization_losses
4layer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses*
* 
* 
_Y
VARIABLE_VALUEdense_16/kernel6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUE*
[U
VARIABLE_VALUEdense_16/bias4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUE*

0
1*

0
1*
* 
�
5non_trainable_variables

6layers
7metrics
8layer_regularization_losses
9layer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses*
* 
* 
_Y
VARIABLE_VALUEdense_17/kernel6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUE*
[U
VARIABLE_VALUEdense_17/bias4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUE*

0
1*

0
1*
* 
�
:non_trainable_variables

;layers
<metrics
=layer_regularization_losses
>layer_metrics
	variables
 trainable_variables
!regularization_losses
#__call__
*$&call_and_return_all_conditional_losses
&$"call_and_return_conditional_losses*
* 
* 
OI
VARIABLE_VALUERMSprop/iter)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUE*
QK
VARIABLE_VALUERMSprop/decay*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUE*
a[
VARIABLE_VALUERMSprop/learning_rate2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUE*
WQ
VARIABLE_VALUERMSprop/momentum-optimizer/momentum/.ATTRIBUTES/VARIABLE_VALUE*
MG
VARIABLE_VALUERMSprop/rho(optimizer/rho/.ATTRIBUTES/VARIABLE_VALUE*
* 

0
1
2*

?0*
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
* 
8
	@total
	Acount
B	variables
C	keras_api*
SM
VARIABLE_VALUEtotal4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUE*
SM
VARIABLE_VALUEcount4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUE*

@0
A1*

B	variables*
��
VARIABLE_VALUERMSprop/dense_15/kernel/rmsTlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUE*
�
VARIABLE_VALUERMSprop/dense_15/bias/rmsRlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUE*
��
VARIABLE_VALUERMSprop/dense_16/kernel/rmsTlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUE*
�
VARIABLE_VALUERMSprop/dense_16/bias/rmsRlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUE*
��
VARIABLE_VALUERMSprop/dense_17/kernel/rmsTlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUE*
�
VARIABLE_VALUERMSprop/dense_17/bias/rmsRlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUE*
�
serving_default_dense_15_inputPlaceholder*+
_output_shapes
:���������*
dtype0* 
shape:���������
�
StatefulPartitionedCallStatefulPartitionedCallserving_default_dense_15_inputdense_15/kerneldense_15/biasdense_16/kerneldense_16/biasdense_17/kerneldense_17/bias*
Tin
	2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*(
_read_only_resource_inputs

*0
config_proto 

CPU

GPU2*0J 8� */
f*R(
&__inference_signature_wrapper_38308433
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
�
StatefulPartitionedCall_1StatefulPartitionedCallsaver_filename#dense_15/kernel/Read/ReadVariableOp!dense_15/bias/Read/ReadVariableOp#dense_16/kernel/Read/ReadVariableOp!dense_16/bias/Read/ReadVariableOp#dense_17/kernel/Read/ReadVariableOp!dense_17/bias/Read/ReadVariableOp RMSprop/iter/Read/ReadVariableOp!RMSprop/decay/Read/ReadVariableOp)RMSprop/learning_rate/Read/ReadVariableOp$RMSprop/momentum/Read/ReadVariableOpRMSprop/rho/Read/ReadVariableOptotal/Read/ReadVariableOpcount/Read/ReadVariableOp/RMSprop/dense_15/kernel/rms/Read/ReadVariableOp-RMSprop/dense_15/bias/rms/Read/ReadVariableOp/RMSprop/dense_16/kernel/rms/Read/ReadVariableOp-RMSprop/dense_16/bias/rms/Read/ReadVariableOp/RMSprop/dense_17/kernel/rms/Read/ReadVariableOp-RMSprop/dense_17/bias/rms/Read/ReadVariableOpConst* 
Tin
2	*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8� **
f%R#
!__inference__traced_save_38308632
�
StatefulPartitionedCall_2StatefulPartitionedCallsaver_filenamedense_15/kerneldense_15/biasdense_16/kerneldense_16/biasdense_17/kerneldense_17/biasRMSprop/iterRMSprop/decayRMSprop/learning_rateRMSprop/momentumRMSprop/rhototalcountRMSprop/dense_15/kernel/rmsRMSprop/dense_15/bias/rmsRMSprop/dense_16/kernel/rmsRMSprop/dense_16/bias/rmsRMSprop/dense_17/kernel/rmsRMSprop/dense_17/bias/rms*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *0
config_proto 

CPU

GPU2*0J 8� *-
f(R&
$__inference__traced_restore_38308699��
�	
�
/__inference_sequential_5_layer_call_fn_38308068
dense_15_input
unknown:
	unknown_0:
	unknown_1:
	unknown_2:
	unknown_3:
	unknown_4:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCalldense_15_inputunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*(
_read_only_resource_inputs

*0
config_proto 

CPU

GPU2*0J 8� *S
fNRL
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308053s
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*6
_input_shapes%
#:���������: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:[ W
+
_output_shapes
:���������
(
_user_specified_namedense_15_input
�
�
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308206
dense_15_input#
dense_15_38308190:
dense_15_38308192:#
dense_16_38308195:
dense_16_38308197:#
dense_17_38308200:
dense_17_38308202:
identity�� dense_15/StatefulPartitionedCall� dense_16/StatefulPartitionedCall� dense_17/StatefulPartitionedCall�
 dense_15/StatefulPartitionedCallStatefulPartitionedCalldense_15_inputdense_15_38308190dense_15_38308192*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_15_layer_call_and_return_conditional_losses_38307973�
 dense_16/StatefulPartitionedCallStatefulPartitionedCall)dense_15/StatefulPartitionedCall:output:0dense_16_38308195dense_16_38308197*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_16_layer_call_and_return_conditional_losses_38308010�
 dense_17/StatefulPartitionedCallStatefulPartitionedCall)dense_16/StatefulPartitionedCall:output:0dense_17_38308200dense_17_38308202*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_17_layer_call_and_return_conditional_losses_38308046|
IdentityIdentity)dense_17/StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:����������
NoOpNoOp!^dense_15/StatefulPartitionedCall!^dense_16/StatefulPartitionedCall!^dense_17/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*6
_input_shapes%
#:���������: : : : : : 2D
 dense_15/StatefulPartitionedCall dense_15/StatefulPartitionedCall2D
 dense_16/StatefulPartitionedCall dense_16/StatefulPartitionedCall2D
 dense_17/StatefulPartitionedCall dense_17/StatefulPartitionedCall:[ W
+
_output_shapes
:���������
(
_user_specified_namedense_15_input
�
�
&__inference_signature_wrapper_38308433
dense_15_input
unknown:
	unknown_0:
	unknown_1:
	unknown_2:
	unknown_3:
	unknown_4:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCalldense_15_inputunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*(
_read_only_resource_inputs

*0
config_proto 

CPU

GPU2*0J 8� *,
f'R%
#__inference__wrapped_model_38307935s
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*6
_input_shapes%
#:���������: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:[ W
+
_output_shapes
:���������
(
_user_specified_namedense_15_input
�
�
F__inference_dense_15_layer_call_and_return_conditional_losses_38308473

inputs3
!tensordot_readvariableop_resource:-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�Tensordot/ReadVariableOpz
Tensordot/ReadVariableOpReadVariableOp!tensordot_readvariableop_resource*
_output_shapes

:*
dtype0X
Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:_
Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       E
Tensordot/ShapeShapeinputs*
T0*
_output_shapes
:Y
Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/GatherV2GatherV2Tensordot/Shape:output:0Tensordot/free:output:0 Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:[
Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/GatherV2_1GatherV2Tensordot/Shape:output:0Tensordot/axes:output:0"Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:Y
Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: n
Tensordot/ProdProdTensordot/GatherV2:output:0Tensordot/Const:output:0*
T0*
_output_shapes
: [
Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: t
Tensordot/Prod_1ProdTensordot/GatherV2_1:output:0Tensordot/Const_1:output:0*
T0*
_output_shapes
: W
Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/concatConcatV2Tensordot/free:output:0Tensordot/axes:output:0Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:y
Tensordot/stackPackTensordot/Prod:output:0Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:y
Tensordot/transpose	TransposeinputsTensordot/concat:output:0*
T0*+
_output_shapes
:����������
Tensordot/ReshapeReshapeTensordot/transpose:y:0Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
Tensordot/MatMulMatMulTensordot/Reshape:output:0 Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������[
Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:Y
Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/concat_1ConcatV2Tensordot/GatherV2:output:0Tensordot/Const_2:output:0 Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
	TensordotReshapeTensordot/MatMul:product:0Tensordot/concat_1:output:0*
T0*+
_output_shapes
:���������r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0|
BiasAddBiasAddTensordot:output:0BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������T
ReluReluBiasAdd:output:0*
T0*+
_output_shapes
:���������e
IdentityIdentityRelu:activations:0^NoOp*
T0*+
_output_shapes
:���������z
NoOpNoOp^BiasAdd/ReadVariableOp^Tensordot/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp24
Tensordot/ReadVariableOpTensordot/ReadVariableOp:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308187
dense_15_input#
dense_15_38308171:
dense_15_38308173:#
dense_16_38308176:
dense_16_38308178:#
dense_17_38308181:
dense_17_38308183:
identity�� dense_15/StatefulPartitionedCall� dense_16/StatefulPartitionedCall� dense_17/StatefulPartitionedCall�
 dense_15/StatefulPartitionedCallStatefulPartitionedCalldense_15_inputdense_15_38308171dense_15_38308173*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_15_layer_call_and_return_conditional_losses_38307973�
 dense_16/StatefulPartitionedCallStatefulPartitionedCall)dense_15/StatefulPartitionedCall:output:0dense_16_38308176dense_16_38308178*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_16_layer_call_and_return_conditional_losses_38308010�
 dense_17/StatefulPartitionedCallStatefulPartitionedCall)dense_16/StatefulPartitionedCall:output:0dense_17_38308181dense_17_38308183*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_17_layer_call_and_return_conditional_losses_38308046|
IdentityIdentity)dense_17/StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:����������
NoOpNoOp!^dense_15/StatefulPartitionedCall!^dense_16/StatefulPartitionedCall!^dense_17/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*6
_input_shapes%
#:���������: : : : : : 2D
 dense_15/StatefulPartitionedCall dense_15/StatefulPartitionedCall2D
 dense_16/StatefulPartitionedCall dense_16/StatefulPartitionedCall2D
 dense_17/StatefulPartitionedCall dense_17/StatefulPartitionedCall:[ W
+
_output_shapes
:���������
(
_user_specified_namedense_15_input
�
�
+__inference_dense_15_layer_call_fn_38308442

inputs
unknown:
	unknown_0:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_15_layer_call_and_return_conditional_losses_38307973s
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : 22
StatefulPartitionedCallStatefulPartitionedCall:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
F__inference_dense_17_layer_call_and_return_conditional_losses_38308046

inputs3
!tensordot_readvariableop_resource:-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�Tensordot/ReadVariableOpz
Tensordot/ReadVariableOpReadVariableOp!tensordot_readvariableop_resource*
_output_shapes

:*
dtype0X
Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:_
Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       E
Tensordot/ShapeShapeinputs*
T0*
_output_shapes
:Y
Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/GatherV2GatherV2Tensordot/Shape:output:0Tensordot/free:output:0 Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:[
Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/GatherV2_1GatherV2Tensordot/Shape:output:0Tensordot/axes:output:0"Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:Y
Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: n
Tensordot/ProdProdTensordot/GatherV2:output:0Tensordot/Const:output:0*
T0*
_output_shapes
: [
Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: t
Tensordot/Prod_1ProdTensordot/GatherV2_1:output:0Tensordot/Const_1:output:0*
T0*
_output_shapes
: W
Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/concatConcatV2Tensordot/free:output:0Tensordot/axes:output:0Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:y
Tensordot/stackPackTensordot/Prod:output:0Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:y
Tensordot/transpose	TransposeinputsTensordot/concat:output:0*
T0*+
_output_shapes
:����������
Tensordot/ReshapeReshapeTensordot/transpose:y:0Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
Tensordot/MatMulMatMulTensordot/Reshape:output:0 Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������[
Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:Y
Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/concat_1ConcatV2Tensordot/GatherV2:output:0Tensordot/Const_2:output:0 Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
	TensordotReshapeTensordot/MatMul:product:0Tensordot/concat_1:output:0*
T0*+
_output_shapes
:���������r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0|
BiasAddBiasAddTensordot:output:0BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������c
IdentityIdentityBiasAdd:output:0^NoOp*
T0*+
_output_shapes
:���������z
NoOpNoOp^BiasAdd/ReadVariableOp^Tensordot/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp24
Tensordot/ReadVariableOpTensordot/ReadVariableOp:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
+__inference_dense_17_layer_call_fn_38308522

inputs
unknown:
	unknown_0:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_17_layer_call_and_return_conditional_losses_38308046s
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : 22
StatefulPartitionedCallStatefulPartitionedCall:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
+__inference_dense_16_layer_call_fn_38308482

inputs
unknown:
	unknown_0:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_16_layer_call_and_return_conditional_losses_38308010s
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : 22
StatefulPartitionedCallStatefulPartitionedCall:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
F__inference_dense_17_layer_call_and_return_conditional_losses_38308552

inputs3
!tensordot_readvariableop_resource:-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�Tensordot/ReadVariableOpz
Tensordot/ReadVariableOpReadVariableOp!tensordot_readvariableop_resource*
_output_shapes

:*
dtype0X
Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:_
Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       E
Tensordot/ShapeShapeinputs*
T0*
_output_shapes
:Y
Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/GatherV2GatherV2Tensordot/Shape:output:0Tensordot/free:output:0 Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:[
Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/GatherV2_1GatherV2Tensordot/Shape:output:0Tensordot/axes:output:0"Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:Y
Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: n
Tensordot/ProdProdTensordot/GatherV2:output:0Tensordot/Const:output:0*
T0*
_output_shapes
: [
Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: t
Tensordot/Prod_1ProdTensordot/GatherV2_1:output:0Tensordot/Const_1:output:0*
T0*
_output_shapes
: W
Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/concatConcatV2Tensordot/free:output:0Tensordot/axes:output:0Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:y
Tensordot/stackPackTensordot/Prod:output:0Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:y
Tensordot/transpose	TransposeinputsTensordot/concat:output:0*
T0*+
_output_shapes
:����������
Tensordot/ReshapeReshapeTensordot/transpose:y:0Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
Tensordot/MatMulMatMulTensordot/Reshape:output:0 Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������[
Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:Y
Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/concat_1ConcatV2Tensordot/GatherV2:output:0Tensordot/Const_2:output:0 Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
	TensordotReshapeTensordot/MatMul:product:0Tensordot/concat_1:output:0*
T0*+
_output_shapes
:���������r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0|
BiasAddBiasAddTensordot:output:0BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������c
IdentityIdentityBiasAdd:output:0^NoOp*
T0*+
_output_shapes
:���������z
NoOpNoOp^BiasAdd/ReadVariableOp^Tensordot/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp24
Tensordot/ReadVariableOpTensordot/ReadVariableOp:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
F__inference_dense_15_layer_call_and_return_conditional_losses_38307973

inputs3
!tensordot_readvariableop_resource:-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�Tensordot/ReadVariableOpz
Tensordot/ReadVariableOpReadVariableOp!tensordot_readvariableop_resource*
_output_shapes

:*
dtype0X
Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:_
Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       E
Tensordot/ShapeShapeinputs*
T0*
_output_shapes
:Y
Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/GatherV2GatherV2Tensordot/Shape:output:0Tensordot/free:output:0 Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:[
Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/GatherV2_1GatherV2Tensordot/Shape:output:0Tensordot/axes:output:0"Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:Y
Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: n
Tensordot/ProdProdTensordot/GatherV2:output:0Tensordot/Const:output:0*
T0*
_output_shapes
: [
Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: t
Tensordot/Prod_1ProdTensordot/GatherV2_1:output:0Tensordot/Const_1:output:0*
T0*
_output_shapes
: W
Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/concatConcatV2Tensordot/free:output:0Tensordot/axes:output:0Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:y
Tensordot/stackPackTensordot/Prod:output:0Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:y
Tensordot/transpose	TransposeinputsTensordot/concat:output:0*
T0*+
_output_shapes
:����������
Tensordot/ReshapeReshapeTensordot/transpose:y:0Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
Tensordot/MatMulMatMulTensordot/Reshape:output:0 Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������[
Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:Y
Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/concat_1ConcatV2Tensordot/GatherV2:output:0Tensordot/Const_2:output:0 Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
	TensordotReshapeTensordot/MatMul:product:0Tensordot/concat_1:output:0*
T0*+
_output_shapes
:���������r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0|
BiasAddBiasAddTensordot:output:0BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������T
ReluReluBiasAdd:output:0*
T0*+
_output_shapes
:���������e
IdentityIdentityRelu:activations:0^NoOp*
T0*+
_output_shapes
:���������z
NoOpNoOp^BiasAdd/ReadVariableOp^Tensordot/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp24
Tensordot/ReadVariableOpTensordot/ReadVariableOp:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
F__inference_dense_16_layer_call_and_return_conditional_losses_38308010

inputs3
!tensordot_readvariableop_resource:-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�Tensordot/ReadVariableOpz
Tensordot/ReadVariableOpReadVariableOp!tensordot_readvariableop_resource*
_output_shapes

:*
dtype0X
Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:_
Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       E
Tensordot/ShapeShapeinputs*
T0*
_output_shapes
:Y
Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/GatherV2GatherV2Tensordot/Shape:output:0Tensordot/free:output:0 Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:[
Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/GatherV2_1GatherV2Tensordot/Shape:output:0Tensordot/axes:output:0"Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:Y
Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: n
Tensordot/ProdProdTensordot/GatherV2:output:0Tensordot/Const:output:0*
T0*
_output_shapes
: [
Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: t
Tensordot/Prod_1ProdTensordot/GatherV2_1:output:0Tensordot/Const_1:output:0*
T0*
_output_shapes
: W
Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/concatConcatV2Tensordot/free:output:0Tensordot/axes:output:0Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:y
Tensordot/stackPackTensordot/Prod:output:0Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:y
Tensordot/transpose	TransposeinputsTensordot/concat:output:0*
T0*+
_output_shapes
:����������
Tensordot/ReshapeReshapeTensordot/transpose:y:0Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
Tensordot/MatMulMatMulTensordot/Reshape:output:0 Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������[
Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:Y
Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/concat_1ConcatV2Tensordot/GatherV2:output:0Tensordot/Const_2:output:0 Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
	TensordotReshapeTensordot/MatMul:product:0Tensordot/concat_1:output:0*
T0*+
_output_shapes
:���������r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0|
BiasAddBiasAddTensordot:output:0BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������T
ReluReluBiasAdd:output:0*
T0*+
_output_shapes
:���������e
IdentityIdentityRelu:activations:0^NoOp*
T0*+
_output_shapes
:���������z
NoOpNoOp^BiasAdd/ReadVariableOp^Tensordot/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp24
Tensordot/ReadVariableOpTensordot/ReadVariableOp:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs
�^
�
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308414

inputs<
*dense_15_tensordot_readvariableop_resource:6
(dense_15_biasadd_readvariableop_resource:<
*dense_16_tensordot_readvariableop_resource:6
(dense_16_biasadd_readvariableop_resource:<
*dense_17_tensordot_readvariableop_resource:6
(dense_17_biasadd_readvariableop_resource:
identity��dense_15/BiasAdd/ReadVariableOp�!dense_15/Tensordot/ReadVariableOp�dense_16/BiasAdd/ReadVariableOp�!dense_16/Tensordot/ReadVariableOp�dense_17/BiasAdd/ReadVariableOp�!dense_17/Tensordot/ReadVariableOp�
!dense_15/Tensordot/ReadVariableOpReadVariableOp*dense_15_tensordot_readvariableop_resource*
_output_shapes

:*
dtype0a
dense_15/Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:h
dense_15/Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       N
dense_15/Tensordot/ShapeShapeinputs*
T0*
_output_shapes
:b
 dense_15/Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_15/Tensordot/GatherV2GatherV2!dense_15/Tensordot/Shape:output:0 dense_15/Tensordot/free:output:0)dense_15/Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:d
"dense_15/Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_15/Tensordot/GatherV2_1GatherV2!dense_15/Tensordot/Shape:output:0 dense_15/Tensordot/axes:output:0+dense_15/Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:b
dense_15/Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: �
dense_15/Tensordot/ProdProd$dense_15/Tensordot/GatherV2:output:0!dense_15/Tensordot/Const:output:0*
T0*
_output_shapes
: d
dense_15/Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: �
dense_15/Tensordot/Prod_1Prod&dense_15/Tensordot/GatherV2_1:output:0#dense_15/Tensordot/Const_1:output:0*
T0*
_output_shapes
: `
dense_15/Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_15/Tensordot/concatConcatV2 dense_15/Tensordot/free:output:0 dense_15/Tensordot/axes:output:0'dense_15/Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:�
dense_15/Tensordot/stackPack dense_15/Tensordot/Prod:output:0"dense_15/Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:�
dense_15/Tensordot/transpose	Transposeinputs"dense_15/Tensordot/concat:output:0*
T0*+
_output_shapes
:����������
dense_15/Tensordot/ReshapeReshape dense_15/Tensordot/transpose:y:0!dense_15/Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
dense_15/Tensordot/MatMulMatMul#dense_15/Tensordot/Reshape:output:0)dense_15/Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������d
dense_15/Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:b
 dense_15/Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_15/Tensordot/concat_1ConcatV2$dense_15/Tensordot/GatherV2:output:0#dense_15/Tensordot/Const_2:output:0)dense_15/Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
dense_15/TensordotReshape#dense_15/Tensordot/MatMul:product:0$dense_15/Tensordot/concat_1:output:0*
T0*+
_output_shapes
:����������
dense_15/BiasAdd/ReadVariableOpReadVariableOp(dense_15_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
dense_15/BiasAddBiasAdddense_15/Tensordot:output:0'dense_15/BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������f
dense_15/ReluReludense_15/BiasAdd:output:0*
T0*+
_output_shapes
:����������
!dense_16/Tensordot/ReadVariableOpReadVariableOp*dense_16_tensordot_readvariableop_resource*
_output_shapes

:*
dtype0a
dense_16/Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:h
dense_16/Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       c
dense_16/Tensordot/ShapeShapedense_15/Relu:activations:0*
T0*
_output_shapes
:b
 dense_16/Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_16/Tensordot/GatherV2GatherV2!dense_16/Tensordot/Shape:output:0 dense_16/Tensordot/free:output:0)dense_16/Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:d
"dense_16/Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_16/Tensordot/GatherV2_1GatherV2!dense_16/Tensordot/Shape:output:0 dense_16/Tensordot/axes:output:0+dense_16/Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:b
dense_16/Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: �
dense_16/Tensordot/ProdProd$dense_16/Tensordot/GatherV2:output:0!dense_16/Tensordot/Const:output:0*
T0*
_output_shapes
: d
dense_16/Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: �
dense_16/Tensordot/Prod_1Prod&dense_16/Tensordot/GatherV2_1:output:0#dense_16/Tensordot/Const_1:output:0*
T0*
_output_shapes
: `
dense_16/Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_16/Tensordot/concatConcatV2 dense_16/Tensordot/free:output:0 dense_16/Tensordot/axes:output:0'dense_16/Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:�
dense_16/Tensordot/stackPack dense_16/Tensordot/Prod:output:0"dense_16/Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:�
dense_16/Tensordot/transpose	Transposedense_15/Relu:activations:0"dense_16/Tensordot/concat:output:0*
T0*+
_output_shapes
:����������
dense_16/Tensordot/ReshapeReshape dense_16/Tensordot/transpose:y:0!dense_16/Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
dense_16/Tensordot/MatMulMatMul#dense_16/Tensordot/Reshape:output:0)dense_16/Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������d
dense_16/Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:b
 dense_16/Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_16/Tensordot/concat_1ConcatV2$dense_16/Tensordot/GatherV2:output:0#dense_16/Tensordot/Const_2:output:0)dense_16/Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
dense_16/TensordotReshape#dense_16/Tensordot/MatMul:product:0$dense_16/Tensordot/concat_1:output:0*
T0*+
_output_shapes
:����������
dense_16/BiasAdd/ReadVariableOpReadVariableOp(dense_16_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
dense_16/BiasAddBiasAdddense_16/Tensordot:output:0'dense_16/BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������f
dense_16/ReluReludense_16/BiasAdd:output:0*
T0*+
_output_shapes
:����������
!dense_17/Tensordot/ReadVariableOpReadVariableOp*dense_17_tensordot_readvariableop_resource*
_output_shapes

:*
dtype0a
dense_17/Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:h
dense_17/Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       c
dense_17/Tensordot/ShapeShapedense_16/Relu:activations:0*
T0*
_output_shapes
:b
 dense_17/Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_17/Tensordot/GatherV2GatherV2!dense_17/Tensordot/Shape:output:0 dense_17/Tensordot/free:output:0)dense_17/Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:d
"dense_17/Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_17/Tensordot/GatherV2_1GatherV2!dense_17/Tensordot/Shape:output:0 dense_17/Tensordot/axes:output:0+dense_17/Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:b
dense_17/Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: �
dense_17/Tensordot/ProdProd$dense_17/Tensordot/GatherV2:output:0!dense_17/Tensordot/Const:output:0*
T0*
_output_shapes
: d
dense_17/Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: �
dense_17/Tensordot/Prod_1Prod&dense_17/Tensordot/GatherV2_1:output:0#dense_17/Tensordot/Const_1:output:0*
T0*
_output_shapes
: `
dense_17/Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_17/Tensordot/concatConcatV2 dense_17/Tensordot/free:output:0 dense_17/Tensordot/axes:output:0'dense_17/Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:�
dense_17/Tensordot/stackPack dense_17/Tensordot/Prod:output:0"dense_17/Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:�
dense_17/Tensordot/transpose	Transposedense_16/Relu:activations:0"dense_17/Tensordot/concat:output:0*
T0*+
_output_shapes
:����������
dense_17/Tensordot/ReshapeReshape dense_17/Tensordot/transpose:y:0!dense_17/Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
dense_17/Tensordot/MatMulMatMul#dense_17/Tensordot/Reshape:output:0)dense_17/Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������d
dense_17/Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:b
 dense_17/Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_17/Tensordot/concat_1ConcatV2$dense_17/Tensordot/GatherV2:output:0#dense_17/Tensordot/Const_2:output:0)dense_17/Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
dense_17/TensordotReshape#dense_17/Tensordot/MatMul:product:0$dense_17/Tensordot/concat_1:output:0*
T0*+
_output_shapes
:����������
dense_17/BiasAdd/ReadVariableOpReadVariableOp(dense_17_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
dense_17/BiasAddBiasAdddense_17/Tensordot:output:0'dense_17/BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������l
IdentityIdentitydense_17/BiasAdd:output:0^NoOp*
T0*+
_output_shapes
:����������
NoOpNoOp ^dense_15/BiasAdd/ReadVariableOp"^dense_15/Tensordot/ReadVariableOp ^dense_16/BiasAdd/ReadVariableOp"^dense_16/Tensordot/ReadVariableOp ^dense_17/BiasAdd/ReadVariableOp"^dense_17/Tensordot/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*6
_input_shapes%
#:���������: : : : : : 2B
dense_15/BiasAdd/ReadVariableOpdense_15/BiasAdd/ReadVariableOp2F
!dense_15/Tensordot/ReadVariableOp!dense_15/Tensordot/ReadVariableOp2B
dense_16/BiasAdd/ReadVariableOpdense_16/BiasAdd/ReadVariableOp2F
!dense_16/Tensordot/ReadVariableOp!dense_16/Tensordot/ReadVariableOp2B
dense_17/BiasAdd/ReadVariableOpdense_17/BiasAdd/ReadVariableOp2F
!dense_17/Tensordot/ReadVariableOp!dense_17/Tensordot/ReadVariableOp:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs
�N
�
$__inference__traced_restore_38308699
file_prefix2
 assignvariableop_dense_15_kernel:.
 assignvariableop_1_dense_15_bias:4
"assignvariableop_2_dense_16_kernel:.
 assignvariableop_3_dense_16_bias:4
"assignvariableop_4_dense_17_kernel:.
 assignvariableop_5_dense_17_bias:)
assignvariableop_6_rmsprop_iter:	 *
 assignvariableop_7_rmsprop_decay: 2
(assignvariableop_8_rmsprop_learning_rate: -
#assignvariableop_9_rmsprop_momentum: )
assignvariableop_10_rmsprop_rho: #
assignvariableop_11_total: #
assignvariableop_12_count: A
/assignvariableop_13_rmsprop_dense_15_kernel_rms:;
-assignvariableop_14_rmsprop_dense_15_bias_rms:A
/assignvariableop_15_rmsprop_dense_16_kernel_rms:;
-assignvariableop_16_rmsprop_dense_16_bias_rms:A
/assignvariableop_17_rmsprop_dense_17_kernel_rms:;
-assignvariableop_18_rmsprop_dense_17_bias_rms:
identity_20��AssignVariableOp�AssignVariableOp_1�AssignVariableOp_10�AssignVariableOp_11�AssignVariableOp_12�AssignVariableOp_13�AssignVariableOp_14�AssignVariableOp_15�AssignVariableOp_16�AssignVariableOp_17�AssignVariableOp_18�AssignVariableOp_2�AssignVariableOp_3�AssignVariableOp_4�AssignVariableOp_5�AssignVariableOp_6�AssignVariableOp_7�AssignVariableOp_8�AssignVariableOp_9�

RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*�	
value�	B�	B6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB-optimizer/momentum/.ATTRIBUTES/VARIABLE_VALUEB(optimizer/rho/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEBTlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUEBTlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUEBTlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH�
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*;
value2B0B B B B B B B B B B B B B B B B B B B B �
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0*d
_output_shapesR
P::::::::::::::::::::*"
dtypes
2	[
IdentityIdentityRestoreV2:tensors:0"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOpAssignVariableOp assignvariableop_dense_15_kernelIdentity:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_1IdentityRestoreV2:tensors:1"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_1AssignVariableOp assignvariableop_1_dense_15_biasIdentity_1:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_2IdentityRestoreV2:tensors:2"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_2AssignVariableOp"assignvariableop_2_dense_16_kernelIdentity_2:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_3IdentityRestoreV2:tensors:3"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_3AssignVariableOp assignvariableop_3_dense_16_biasIdentity_3:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_4IdentityRestoreV2:tensors:4"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_4AssignVariableOp"assignvariableop_4_dense_17_kernelIdentity_4:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_5IdentityRestoreV2:tensors:5"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_5AssignVariableOp assignvariableop_5_dense_17_biasIdentity_5:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_6IdentityRestoreV2:tensors:6"/device:CPU:0*
T0	*
_output_shapes
:�
AssignVariableOp_6AssignVariableOpassignvariableop_6_rmsprop_iterIdentity_6:output:0"/device:CPU:0*
_output_shapes
 *
dtype0	]

Identity_7IdentityRestoreV2:tensors:7"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_7AssignVariableOp assignvariableop_7_rmsprop_decayIdentity_7:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_8IdentityRestoreV2:tensors:8"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_8AssignVariableOp(assignvariableop_8_rmsprop_learning_rateIdentity_8:output:0"/device:CPU:0*
_output_shapes
 *
dtype0]

Identity_9IdentityRestoreV2:tensors:9"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_9AssignVariableOp#assignvariableop_9_rmsprop_momentumIdentity_9:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_10IdentityRestoreV2:tensors:10"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_10AssignVariableOpassignvariableop_10_rmsprop_rhoIdentity_10:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_11IdentityRestoreV2:tensors:11"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_11AssignVariableOpassignvariableop_11_totalIdentity_11:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_12IdentityRestoreV2:tensors:12"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_12AssignVariableOpassignvariableop_12_countIdentity_12:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_13IdentityRestoreV2:tensors:13"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_13AssignVariableOp/assignvariableop_13_rmsprop_dense_15_kernel_rmsIdentity_13:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_14IdentityRestoreV2:tensors:14"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_14AssignVariableOp-assignvariableop_14_rmsprop_dense_15_bias_rmsIdentity_14:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_15IdentityRestoreV2:tensors:15"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_15AssignVariableOp/assignvariableop_15_rmsprop_dense_16_kernel_rmsIdentity_15:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_16IdentityRestoreV2:tensors:16"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_16AssignVariableOp-assignvariableop_16_rmsprop_dense_16_bias_rmsIdentity_16:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_17IdentityRestoreV2:tensors:17"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_17AssignVariableOp/assignvariableop_17_rmsprop_dense_17_kernel_rmsIdentity_17:output:0"/device:CPU:0*
_output_shapes
 *
dtype0_
Identity_18IdentityRestoreV2:tensors:18"/device:CPU:0*
T0*
_output_shapes
:�
AssignVariableOp_18AssignVariableOp-assignvariableop_18_rmsprop_dense_17_bias_rmsIdentity_18:output:0"/device:CPU:0*
_output_shapes
 *
dtype01
NoOpNoOp"/device:CPU:0*
_output_shapes
 �
Identity_19Identityfile_prefix^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_14^AssignVariableOp_15^AssignVariableOp_16^AssignVariableOp_17^AssignVariableOp_18^AssignVariableOp_2^AssignVariableOp_3^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9^NoOp"/device:CPU:0*
T0*
_output_shapes
: W
Identity_20IdentityIdentity_19:output:0^NoOp_1*
T0*
_output_shapes
: �
NoOp_1NoOp^AssignVariableOp^AssignVariableOp_1^AssignVariableOp_10^AssignVariableOp_11^AssignVariableOp_12^AssignVariableOp_13^AssignVariableOp_14^AssignVariableOp_15^AssignVariableOp_16^AssignVariableOp_17^AssignVariableOp_18^AssignVariableOp_2^AssignVariableOp_3^AssignVariableOp_4^AssignVariableOp_5^AssignVariableOp_6^AssignVariableOp_7^AssignVariableOp_8^AssignVariableOp_9*"
_acd_function_control_output(*
_output_shapes
 "#
identity_20Identity_20:output:0*;
_input_shapes*
(: : : : : : : : : : : : : : : : : : : : 2$
AssignVariableOpAssignVariableOp2(
AssignVariableOp_1AssignVariableOp_12*
AssignVariableOp_10AssignVariableOp_102*
AssignVariableOp_11AssignVariableOp_112*
AssignVariableOp_12AssignVariableOp_122*
AssignVariableOp_13AssignVariableOp_132*
AssignVariableOp_14AssignVariableOp_142*
AssignVariableOp_15AssignVariableOp_152*
AssignVariableOp_16AssignVariableOp_162*
AssignVariableOp_17AssignVariableOp_172*
AssignVariableOp_18AssignVariableOp_182(
AssignVariableOp_2AssignVariableOp_22(
AssignVariableOp_3AssignVariableOp_32(
AssignVariableOp_4AssignVariableOp_42(
AssignVariableOp_5AssignVariableOp_52(
AssignVariableOp_6AssignVariableOp_62(
AssignVariableOp_7AssignVariableOp_72(
AssignVariableOp_8AssignVariableOp_82(
AssignVariableOp_9AssignVariableOp_9:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix
�.
�
!__inference__traced_save_38308632
file_prefix.
*savev2_dense_15_kernel_read_readvariableop,
(savev2_dense_15_bias_read_readvariableop.
*savev2_dense_16_kernel_read_readvariableop,
(savev2_dense_16_bias_read_readvariableop.
*savev2_dense_17_kernel_read_readvariableop,
(savev2_dense_17_bias_read_readvariableop+
'savev2_rmsprop_iter_read_readvariableop	,
(savev2_rmsprop_decay_read_readvariableop4
0savev2_rmsprop_learning_rate_read_readvariableop/
+savev2_rmsprop_momentum_read_readvariableop*
&savev2_rmsprop_rho_read_readvariableop$
 savev2_total_read_readvariableop$
 savev2_count_read_readvariableop:
6savev2_rmsprop_dense_15_kernel_rms_read_readvariableop8
4savev2_rmsprop_dense_15_bias_rms_read_readvariableop:
6savev2_rmsprop_dense_16_kernel_rms_read_readvariableop8
4savev2_rmsprop_dense_16_bias_rms_read_readvariableop:
6savev2_rmsprop_dense_17_kernel_rms_read_readvariableop8
4savev2_rmsprop_dense_17_bias_rms_read_readvariableop
savev2_const

identity_1��MergeV2Checkpointsw
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*Z
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.parta
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/part�
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: f

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: L

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :f
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : �
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: �

SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*�	
value�	B�	B6layer_with_weights-0/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-0/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-1/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-1/bias/.ATTRIBUTES/VARIABLE_VALUEB6layer_with_weights-2/kernel/.ATTRIBUTES/VARIABLE_VALUEB4layer_with_weights-2/bias/.ATTRIBUTES/VARIABLE_VALUEB)optimizer/iter/.ATTRIBUTES/VARIABLE_VALUEB*optimizer/decay/.ATTRIBUTES/VARIABLE_VALUEB2optimizer/learning_rate/.ATTRIBUTES/VARIABLE_VALUEB-optimizer/momentum/.ATTRIBUTES/VARIABLE_VALUEB(optimizer/rho/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/total/.ATTRIBUTES/VARIABLE_VALUEB4keras_api/metrics/0/count/.ATTRIBUTES/VARIABLE_VALUEBTlayer_with_weights-0/kernel/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-0/bias/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUEBTlayer_with_weights-1/kernel/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-1/bias/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUEBTlayer_with_weights-2/kernel/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUEBRlayer_with_weights-2/bias/.OPTIMIZER_SLOT/optimizer/rms/.ATTRIBUTES/VARIABLE_VALUEB_CHECKPOINTABLE_OBJECT_GRAPH�
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*;
value2B0B B B B B B B B B B B B B B B B B B B B �
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:0*savev2_dense_15_kernel_read_readvariableop(savev2_dense_15_bias_read_readvariableop*savev2_dense_16_kernel_read_readvariableop(savev2_dense_16_bias_read_readvariableop*savev2_dense_17_kernel_read_readvariableop(savev2_dense_17_bias_read_readvariableop'savev2_rmsprop_iter_read_readvariableop(savev2_rmsprop_decay_read_readvariableop0savev2_rmsprop_learning_rate_read_readvariableop+savev2_rmsprop_momentum_read_readvariableop&savev2_rmsprop_rho_read_readvariableop savev2_total_read_readvariableop savev2_count_read_readvariableop6savev2_rmsprop_dense_15_kernel_rms_read_readvariableop4savev2_rmsprop_dense_15_bias_rms_read_readvariableop6savev2_rmsprop_dense_16_kernel_rms_read_readvariableop4savev2_rmsprop_dense_16_bias_rms_read_readvariableop6savev2_rmsprop_dense_17_kernel_rms_read_readvariableop4savev2_rmsprop_dense_17_bias_rms_read_readvariableopsavev2_const"/device:CPU:0*
_output_shapes
 *"
dtypes
2	�
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:�
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*
_output_shapes
 f
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: Q

Identity_1IdentityIdentity:output:0^NoOp*
T0*
_output_shapes
: [
NoOpNoOp^MergeV2Checkpoints*"
_acd_function_control_output(*
_output_shapes
 "!

identity_1Identity_1:output:0*�
_input_shapest
r: ::::::: : : : : : : ::::::: 2(
MergeV2CheckpointsMergeV2Checkpoints:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix:$ 

_output_shapes

:: 

_output_shapes
::$ 

_output_shapes

:: 

_output_shapes
::$ 

_output_shapes

:: 

_output_shapes
::

_output_shapes
: :

_output_shapes
: :	

_output_shapes
: :


_output_shapes
: :

_output_shapes
: :

_output_shapes
: :

_output_shapes
: :$ 

_output_shapes

:: 

_output_shapes
::$ 

_output_shapes

:: 

_output_shapes
::$ 

_output_shapes

:: 

_output_shapes
::

_output_shapes
: 
�	
�
/__inference_sequential_5_layer_call_fn_38308229

inputs
unknown:
	unknown_0:
	unknown_1:
	unknown_2:
	unknown_3:
	unknown_4:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*(
_read_only_resource_inputs

*0
config_proto 

CPU

GPU2*0J 8� *S
fNRL
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308053s
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*6
_input_shapes%
#:���������: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs
�	
�
/__inference_sequential_5_layer_call_fn_38308246

inputs
unknown:
	unknown_0:
	unknown_1:
	unknown_2:
	unknown_3:
	unknown_4:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCallinputsunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*(
_read_only_resource_inputs

*0
config_proto 

CPU

GPU2*0J 8� *S
fNRL
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308136s
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*6
_input_shapes%
#:���������: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs
�
�
F__inference_dense_16_layer_call_and_return_conditional_losses_38308513

inputs3
!tensordot_readvariableop_resource:-
biasadd_readvariableop_resource:
identity��BiasAdd/ReadVariableOp�Tensordot/ReadVariableOpz
Tensordot/ReadVariableOpReadVariableOp!tensordot_readvariableop_resource*
_output_shapes

:*
dtype0X
Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:_
Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       E
Tensordot/ShapeShapeinputs*
T0*
_output_shapes
:Y
Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/GatherV2GatherV2Tensordot/Shape:output:0Tensordot/free:output:0 Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:[
Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/GatherV2_1GatherV2Tensordot/Shape:output:0Tensordot/axes:output:0"Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:Y
Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: n
Tensordot/ProdProdTensordot/GatherV2:output:0Tensordot/Const:output:0*
T0*
_output_shapes
: [
Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: t
Tensordot/Prod_1ProdTensordot/GatherV2_1:output:0Tensordot/Const_1:output:0*
T0*
_output_shapes
: W
Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/concatConcatV2Tensordot/free:output:0Tensordot/axes:output:0Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:y
Tensordot/stackPackTensordot/Prod:output:0Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:y
Tensordot/transpose	TransposeinputsTensordot/concat:output:0*
T0*+
_output_shapes
:����������
Tensordot/ReshapeReshapeTensordot/transpose:y:0Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
Tensordot/MatMulMatMulTensordot/Reshape:output:0 Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������[
Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:Y
Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
Tensordot/concat_1ConcatV2Tensordot/GatherV2:output:0Tensordot/Const_2:output:0 Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
	TensordotReshapeTensordot/MatMul:product:0Tensordot/concat_1:output:0*
T0*+
_output_shapes
:���������r
BiasAdd/ReadVariableOpReadVariableOpbiasadd_readvariableop_resource*
_output_shapes
:*
dtype0|
BiasAddBiasAddTensordot:output:0BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������T
ReluReluBiasAdd:output:0*
T0*+
_output_shapes
:���������e
IdentityIdentityRelu:activations:0^NoOp*
T0*+
_output_shapes
:���������z
NoOpNoOp^BiasAdd/ReadVariableOp^Tensordot/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*.
_input_shapes
:���������: : 20
BiasAdd/ReadVariableOpBiasAdd/ReadVariableOp24
Tensordot/ReadVariableOpTensordot/ReadVariableOp:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs
�r
�
#__inference__wrapped_model_38307935
dense_15_inputI
7sequential_5_dense_15_tensordot_readvariableop_resource:C
5sequential_5_dense_15_biasadd_readvariableop_resource:I
7sequential_5_dense_16_tensordot_readvariableop_resource:C
5sequential_5_dense_16_biasadd_readvariableop_resource:I
7sequential_5_dense_17_tensordot_readvariableop_resource:C
5sequential_5_dense_17_biasadd_readvariableop_resource:
identity��,sequential_5/dense_15/BiasAdd/ReadVariableOp�.sequential_5/dense_15/Tensordot/ReadVariableOp�,sequential_5/dense_16/BiasAdd/ReadVariableOp�.sequential_5/dense_16/Tensordot/ReadVariableOp�,sequential_5/dense_17/BiasAdd/ReadVariableOp�.sequential_5/dense_17/Tensordot/ReadVariableOp�
.sequential_5/dense_15/Tensordot/ReadVariableOpReadVariableOp7sequential_5_dense_15_tensordot_readvariableop_resource*
_output_shapes

:*
dtype0n
$sequential_5/dense_15/Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:u
$sequential_5/dense_15/Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       c
%sequential_5/dense_15/Tensordot/ShapeShapedense_15_input*
T0*
_output_shapes
:o
-sequential_5/dense_15/Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
(sequential_5/dense_15/Tensordot/GatherV2GatherV2.sequential_5/dense_15/Tensordot/Shape:output:0-sequential_5/dense_15/Tensordot/free:output:06sequential_5/dense_15/Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:q
/sequential_5/dense_15/Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
*sequential_5/dense_15/Tensordot/GatherV2_1GatherV2.sequential_5/dense_15/Tensordot/Shape:output:0-sequential_5/dense_15/Tensordot/axes:output:08sequential_5/dense_15/Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:o
%sequential_5/dense_15/Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: �
$sequential_5/dense_15/Tensordot/ProdProd1sequential_5/dense_15/Tensordot/GatherV2:output:0.sequential_5/dense_15/Tensordot/Const:output:0*
T0*
_output_shapes
: q
'sequential_5/dense_15/Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: �
&sequential_5/dense_15/Tensordot/Prod_1Prod3sequential_5/dense_15/Tensordot/GatherV2_1:output:00sequential_5/dense_15/Tensordot/Const_1:output:0*
T0*
_output_shapes
: m
+sequential_5/dense_15/Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
&sequential_5/dense_15/Tensordot/concatConcatV2-sequential_5/dense_15/Tensordot/free:output:0-sequential_5/dense_15/Tensordot/axes:output:04sequential_5/dense_15/Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:�
%sequential_5/dense_15/Tensordot/stackPack-sequential_5/dense_15/Tensordot/Prod:output:0/sequential_5/dense_15/Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:�
)sequential_5/dense_15/Tensordot/transpose	Transposedense_15_input/sequential_5/dense_15/Tensordot/concat:output:0*
T0*+
_output_shapes
:����������
'sequential_5/dense_15/Tensordot/ReshapeReshape-sequential_5/dense_15/Tensordot/transpose:y:0.sequential_5/dense_15/Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
&sequential_5/dense_15/Tensordot/MatMulMatMul0sequential_5/dense_15/Tensordot/Reshape:output:06sequential_5/dense_15/Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������q
'sequential_5/dense_15/Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:o
-sequential_5/dense_15/Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
(sequential_5/dense_15/Tensordot/concat_1ConcatV21sequential_5/dense_15/Tensordot/GatherV2:output:00sequential_5/dense_15/Tensordot/Const_2:output:06sequential_5/dense_15/Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
sequential_5/dense_15/TensordotReshape0sequential_5/dense_15/Tensordot/MatMul:product:01sequential_5/dense_15/Tensordot/concat_1:output:0*
T0*+
_output_shapes
:����������
,sequential_5/dense_15/BiasAdd/ReadVariableOpReadVariableOp5sequential_5_dense_15_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
sequential_5/dense_15/BiasAddBiasAdd(sequential_5/dense_15/Tensordot:output:04sequential_5/dense_15/BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:����������
sequential_5/dense_15/ReluRelu&sequential_5/dense_15/BiasAdd:output:0*
T0*+
_output_shapes
:����������
.sequential_5/dense_16/Tensordot/ReadVariableOpReadVariableOp7sequential_5_dense_16_tensordot_readvariableop_resource*
_output_shapes

:*
dtype0n
$sequential_5/dense_16/Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:u
$sequential_5/dense_16/Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       }
%sequential_5/dense_16/Tensordot/ShapeShape(sequential_5/dense_15/Relu:activations:0*
T0*
_output_shapes
:o
-sequential_5/dense_16/Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
(sequential_5/dense_16/Tensordot/GatherV2GatherV2.sequential_5/dense_16/Tensordot/Shape:output:0-sequential_5/dense_16/Tensordot/free:output:06sequential_5/dense_16/Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:q
/sequential_5/dense_16/Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
*sequential_5/dense_16/Tensordot/GatherV2_1GatherV2.sequential_5/dense_16/Tensordot/Shape:output:0-sequential_5/dense_16/Tensordot/axes:output:08sequential_5/dense_16/Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:o
%sequential_5/dense_16/Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: �
$sequential_5/dense_16/Tensordot/ProdProd1sequential_5/dense_16/Tensordot/GatherV2:output:0.sequential_5/dense_16/Tensordot/Const:output:0*
T0*
_output_shapes
: q
'sequential_5/dense_16/Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: �
&sequential_5/dense_16/Tensordot/Prod_1Prod3sequential_5/dense_16/Tensordot/GatherV2_1:output:00sequential_5/dense_16/Tensordot/Const_1:output:0*
T0*
_output_shapes
: m
+sequential_5/dense_16/Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
&sequential_5/dense_16/Tensordot/concatConcatV2-sequential_5/dense_16/Tensordot/free:output:0-sequential_5/dense_16/Tensordot/axes:output:04sequential_5/dense_16/Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:�
%sequential_5/dense_16/Tensordot/stackPack-sequential_5/dense_16/Tensordot/Prod:output:0/sequential_5/dense_16/Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:�
)sequential_5/dense_16/Tensordot/transpose	Transpose(sequential_5/dense_15/Relu:activations:0/sequential_5/dense_16/Tensordot/concat:output:0*
T0*+
_output_shapes
:����������
'sequential_5/dense_16/Tensordot/ReshapeReshape-sequential_5/dense_16/Tensordot/transpose:y:0.sequential_5/dense_16/Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
&sequential_5/dense_16/Tensordot/MatMulMatMul0sequential_5/dense_16/Tensordot/Reshape:output:06sequential_5/dense_16/Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������q
'sequential_5/dense_16/Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:o
-sequential_5/dense_16/Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
(sequential_5/dense_16/Tensordot/concat_1ConcatV21sequential_5/dense_16/Tensordot/GatherV2:output:00sequential_5/dense_16/Tensordot/Const_2:output:06sequential_5/dense_16/Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
sequential_5/dense_16/TensordotReshape0sequential_5/dense_16/Tensordot/MatMul:product:01sequential_5/dense_16/Tensordot/concat_1:output:0*
T0*+
_output_shapes
:����������
,sequential_5/dense_16/BiasAdd/ReadVariableOpReadVariableOp5sequential_5_dense_16_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
sequential_5/dense_16/BiasAddBiasAdd(sequential_5/dense_16/Tensordot:output:04sequential_5/dense_16/BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:����������
sequential_5/dense_16/ReluRelu&sequential_5/dense_16/BiasAdd:output:0*
T0*+
_output_shapes
:����������
.sequential_5/dense_17/Tensordot/ReadVariableOpReadVariableOp7sequential_5_dense_17_tensordot_readvariableop_resource*
_output_shapes

:*
dtype0n
$sequential_5/dense_17/Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:u
$sequential_5/dense_17/Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       }
%sequential_5/dense_17/Tensordot/ShapeShape(sequential_5/dense_16/Relu:activations:0*
T0*
_output_shapes
:o
-sequential_5/dense_17/Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
(sequential_5/dense_17/Tensordot/GatherV2GatherV2.sequential_5/dense_17/Tensordot/Shape:output:0-sequential_5/dense_17/Tensordot/free:output:06sequential_5/dense_17/Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:q
/sequential_5/dense_17/Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
*sequential_5/dense_17/Tensordot/GatherV2_1GatherV2.sequential_5/dense_17/Tensordot/Shape:output:0-sequential_5/dense_17/Tensordot/axes:output:08sequential_5/dense_17/Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:o
%sequential_5/dense_17/Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: �
$sequential_5/dense_17/Tensordot/ProdProd1sequential_5/dense_17/Tensordot/GatherV2:output:0.sequential_5/dense_17/Tensordot/Const:output:0*
T0*
_output_shapes
: q
'sequential_5/dense_17/Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: �
&sequential_5/dense_17/Tensordot/Prod_1Prod3sequential_5/dense_17/Tensordot/GatherV2_1:output:00sequential_5/dense_17/Tensordot/Const_1:output:0*
T0*
_output_shapes
: m
+sequential_5/dense_17/Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
&sequential_5/dense_17/Tensordot/concatConcatV2-sequential_5/dense_17/Tensordot/free:output:0-sequential_5/dense_17/Tensordot/axes:output:04sequential_5/dense_17/Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:�
%sequential_5/dense_17/Tensordot/stackPack-sequential_5/dense_17/Tensordot/Prod:output:0/sequential_5/dense_17/Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:�
)sequential_5/dense_17/Tensordot/transpose	Transpose(sequential_5/dense_16/Relu:activations:0/sequential_5/dense_17/Tensordot/concat:output:0*
T0*+
_output_shapes
:����������
'sequential_5/dense_17/Tensordot/ReshapeReshape-sequential_5/dense_17/Tensordot/transpose:y:0.sequential_5/dense_17/Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
&sequential_5/dense_17/Tensordot/MatMulMatMul0sequential_5/dense_17/Tensordot/Reshape:output:06sequential_5/dense_17/Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������q
'sequential_5/dense_17/Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:o
-sequential_5/dense_17/Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
(sequential_5/dense_17/Tensordot/concat_1ConcatV21sequential_5/dense_17/Tensordot/GatherV2:output:00sequential_5/dense_17/Tensordot/Const_2:output:06sequential_5/dense_17/Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
sequential_5/dense_17/TensordotReshape0sequential_5/dense_17/Tensordot/MatMul:product:01sequential_5/dense_17/Tensordot/concat_1:output:0*
T0*+
_output_shapes
:����������
,sequential_5/dense_17/BiasAdd/ReadVariableOpReadVariableOp5sequential_5_dense_17_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
sequential_5/dense_17/BiasAddBiasAdd(sequential_5/dense_17/Tensordot:output:04sequential_5/dense_17/BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������y
IdentityIdentity&sequential_5/dense_17/BiasAdd:output:0^NoOp*
T0*+
_output_shapes
:����������
NoOpNoOp-^sequential_5/dense_15/BiasAdd/ReadVariableOp/^sequential_5/dense_15/Tensordot/ReadVariableOp-^sequential_5/dense_16/BiasAdd/ReadVariableOp/^sequential_5/dense_16/Tensordot/ReadVariableOp-^sequential_5/dense_17/BiasAdd/ReadVariableOp/^sequential_5/dense_17/Tensordot/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*6
_input_shapes%
#:���������: : : : : : 2\
,sequential_5/dense_15/BiasAdd/ReadVariableOp,sequential_5/dense_15/BiasAdd/ReadVariableOp2`
.sequential_5/dense_15/Tensordot/ReadVariableOp.sequential_5/dense_15/Tensordot/ReadVariableOp2\
,sequential_5/dense_16/BiasAdd/ReadVariableOp,sequential_5/dense_16/BiasAdd/ReadVariableOp2`
.sequential_5/dense_16/Tensordot/ReadVariableOp.sequential_5/dense_16/Tensordot/ReadVariableOp2\
,sequential_5/dense_17/BiasAdd/ReadVariableOp,sequential_5/dense_17/BiasAdd/ReadVariableOp2`
.sequential_5/dense_17/Tensordot/ReadVariableOp.sequential_5/dense_17/Tensordot/ReadVariableOp:[ W
+
_output_shapes
:���������
(
_user_specified_namedense_15_input
�
�
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308136

inputs#
dense_15_38308120:
dense_15_38308122:#
dense_16_38308125:
dense_16_38308127:#
dense_17_38308130:
dense_17_38308132:
identity�� dense_15/StatefulPartitionedCall� dense_16/StatefulPartitionedCall� dense_17/StatefulPartitionedCall�
 dense_15/StatefulPartitionedCallStatefulPartitionedCallinputsdense_15_38308120dense_15_38308122*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_15_layer_call_and_return_conditional_losses_38307973�
 dense_16/StatefulPartitionedCallStatefulPartitionedCall)dense_15/StatefulPartitionedCall:output:0dense_16_38308125dense_16_38308127*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_16_layer_call_and_return_conditional_losses_38308010�
 dense_17/StatefulPartitionedCallStatefulPartitionedCall)dense_16/StatefulPartitionedCall:output:0dense_17_38308130dense_17_38308132*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_17_layer_call_and_return_conditional_losses_38308046|
IdentityIdentity)dense_17/StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:����������
NoOpNoOp!^dense_15/StatefulPartitionedCall!^dense_16/StatefulPartitionedCall!^dense_17/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*6
_input_shapes%
#:���������: : : : : : 2D
 dense_15/StatefulPartitionedCall dense_15/StatefulPartitionedCall2D
 dense_16/StatefulPartitionedCall dense_16/StatefulPartitionedCall2D
 dense_17/StatefulPartitionedCall dense_17/StatefulPartitionedCall:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs
�	
�
/__inference_sequential_5_layer_call_fn_38308168
dense_15_input
unknown:
	unknown_0:
	unknown_1:
	unknown_2:
	unknown_3:
	unknown_4:
identity��StatefulPartitionedCall�
StatefulPartitionedCallStatefulPartitionedCalldense_15_inputunknown	unknown_0	unknown_1	unknown_2	unknown_3	unknown_4*
Tin
	2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*(
_read_only_resource_inputs

*0
config_proto 

CPU

GPU2*0J 8� *S
fNRL
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308136s
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:���������`
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*6
_input_shapes%
#:���������: : : : : : 22
StatefulPartitionedCallStatefulPartitionedCall:[ W
+
_output_shapes
:���������
(
_user_specified_namedense_15_input
�
�
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308053

inputs#
dense_15_38307974:
dense_15_38307976:#
dense_16_38308011:
dense_16_38308013:#
dense_17_38308047:
dense_17_38308049:
identity�� dense_15/StatefulPartitionedCall� dense_16/StatefulPartitionedCall� dense_17/StatefulPartitionedCall�
 dense_15/StatefulPartitionedCallStatefulPartitionedCallinputsdense_15_38307974dense_15_38307976*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_15_layer_call_and_return_conditional_losses_38307973�
 dense_16/StatefulPartitionedCallStatefulPartitionedCall)dense_15/StatefulPartitionedCall:output:0dense_16_38308011dense_16_38308013*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_16_layer_call_and_return_conditional_losses_38308010�
 dense_17/StatefulPartitionedCallStatefulPartitionedCall)dense_16/StatefulPartitionedCall:output:0dense_17_38308047dense_17_38308049*
Tin
2*
Tout
2*
_collective_manager_ids
 *+
_output_shapes
:���������*$
_read_only_resource_inputs
*0
config_proto 

CPU

GPU2*0J 8� *O
fJRH
F__inference_dense_17_layer_call_and_return_conditional_losses_38308046|
IdentityIdentity)dense_17/StatefulPartitionedCall:output:0^NoOp*
T0*+
_output_shapes
:����������
NoOpNoOp!^dense_15/StatefulPartitionedCall!^dense_16/StatefulPartitionedCall!^dense_17/StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*6
_input_shapes%
#:���������: : : : : : 2D
 dense_15/StatefulPartitionedCall dense_15/StatefulPartitionedCall2D
 dense_16/StatefulPartitionedCall dense_16/StatefulPartitionedCall2D
 dense_17/StatefulPartitionedCall dense_17/StatefulPartitionedCall:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs
�^
�
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308330

inputs<
*dense_15_tensordot_readvariableop_resource:6
(dense_15_biasadd_readvariableop_resource:<
*dense_16_tensordot_readvariableop_resource:6
(dense_16_biasadd_readvariableop_resource:<
*dense_17_tensordot_readvariableop_resource:6
(dense_17_biasadd_readvariableop_resource:
identity��dense_15/BiasAdd/ReadVariableOp�!dense_15/Tensordot/ReadVariableOp�dense_16/BiasAdd/ReadVariableOp�!dense_16/Tensordot/ReadVariableOp�dense_17/BiasAdd/ReadVariableOp�!dense_17/Tensordot/ReadVariableOp�
!dense_15/Tensordot/ReadVariableOpReadVariableOp*dense_15_tensordot_readvariableop_resource*
_output_shapes

:*
dtype0a
dense_15/Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:h
dense_15/Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       N
dense_15/Tensordot/ShapeShapeinputs*
T0*
_output_shapes
:b
 dense_15/Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_15/Tensordot/GatherV2GatherV2!dense_15/Tensordot/Shape:output:0 dense_15/Tensordot/free:output:0)dense_15/Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:d
"dense_15/Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_15/Tensordot/GatherV2_1GatherV2!dense_15/Tensordot/Shape:output:0 dense_15/Tensordot/axes:output:0+dense_15/Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:b
dense_15/Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: �
dense_15/Tensordot/ProdProd$dense_15/Tensordot/GatherV2:output:0!dense_15/Tensordot/Const:output:0*
T0*
_output_shapes
: d
dense_15/Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: �
dense_15/Tensordot/Prod_1Prod&dense_15/Tensordot/GatherV2_1:output:0#dense_15/Tensordot/Const_1:output:0*
T0*
_output_shapes
: `
dense_15/Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_15/Tensordot/concatConcatV2 dense_15/Tensordot/free:output:0 dense_15/Tensordot/axes:output:0'dense_15/Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:�
dense_15/Tensordot/stackPack dense_15/Tensordot/Prod:output:0"dense_15/Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:�
dense_15/Tensordot/transpose	Transposeinputs"dense_15/Tensordot/concat:output:0*
T0*+
_output_shapes
:����������
dense_15/Tensordot/ReshapeReshape dense_15/Tensordot/transpose:y:0!dense_15/Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
dense_15/Tensordot/MatMulMatMul#dense_15/Tensordot/Reshape:output:0)dense_15/Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������d
dense_15/Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:b
 dense_15/Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_15/Tensordot/concat_1ConcatV2$dense_15/Tensordot/GatherV2:output:0#dense_15/Tensordot/Const_2:output:0)dense_15/Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
dense_15/TensordotReshape#dense_15/Tensordot/MatMul:product:0$dense_15/Tensordot/concat_1:output:0*
T0*+
_output_shapes
:����������
dense_15/BiasAdd/ReadVariableOpReadVariableOp(dense_15_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
dense_15/BiasAddBiasAdddense_15/Tensordot:output:0'dense_15/BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������f
dense_15/ReluReludense_15/BiasAdd:output:0*
T0*+
_output_shapes
:����������
!dense_16/Tensordot/ReadVariableOpReadVariableOp*dense_16_tensordot_readvariableop_resource*
_output_shapes

:*
dtype0a
dense_16/Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:h
dense_16/Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       c
dense_16/Tensordot/ShapeShapedense_15/Relu:activations:0*
T0*
_output_shapes
:b
 dense_16/Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_16/Tensordot/GatherV2GatherV2!dense_16/Tensordot/Shape:output:0 dense_16/Tensordot/free:output:0)dense_16/Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:d
"dense_16/Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_16/Tensordot/GatherV2_1GatherV2!dense_16/Tensordot/Shape:output:0 dense_16/Tensordot/axes:output:0+dense_16/Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:b
dense_16/Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: �
dense_16/Tensordot/ProdProd$dense_16/Tensordot/GatherV2:output:0!dense_16/Tensordot/Const:output:0*
T0*
_output_shapes
: d
dense_16/Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: �
dense_16/Tensordot/Prod_1Prod&dense_16/Tensordot/GatherV2_1:output:0#dense_16/Tensordot/Const_1:output:0*
T0*
_output_shapes
: `
dense_16/Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_16/Tensordot/concatConcatV2 dense_16/Tensordot/free:output:0 dense_16/Tensordot/axes:output:0'dense_16/Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:�
dense_16/Tensordot/stackPack dense_16/Tensordot/Prod:output:0"dense_16/Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:�
dense_16/Tensordot/transpose	Transposedense_15/Relu:activations:0"dense_16/Tensordot/concat:output:0*
T0*+
_output_shapes
:����������
dense_16/Tensordot/ReshapeReshape dense_16/Tensordot/transpose:y:0!dense_16/Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
dense_16/Tensordot/MatMulMatMul#dense_16/Tensordot/Reshape:output:0)dense_16/Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������d
dense_16/Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:b
 dense_16/Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_16/Tensordot/concat_1ConcatV2$dense_16/Tensordot/GatherV2:output:0#dense_16/Tensordot/Const_2:output:0)dense_16/Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
dense_16/TensordotReshape#dense_16/Tensordot/MatMul:product:0$dense_16/Tensordot/concat_1:output:0*
T0*+
_output_shapes
:����������
dense_16/BiasAdd/ReadVariableOpReadVariableOp(dense_16_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
dense_16/BiasAddBiasAdddense_16/Tensordot:output:0'dense_16/BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������f
dense_16/ReluReludense_16/BiasAdd:output:0*
T0*+
_output_shapes
:����������
!dense_17/Tensordot/ReadVariableOpReadVariableOp*dense_17_tensordot_readvariableop_resource*
_output_shapes

:*
dtype0a
dense_17/Tensordot/axesConst*
_output_shapes
:*
dtype0*
valueB:h
dense_17/Tensordot/freeConst*
_output_shapes
:*
dtype0*
valueB"       c
dense_17/Tensordot/ShapeShapedense_16/Relu:activations:0*
T0*
_output_shapes
:b
 dense_17/Tensordot/GatherV2/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_17/Tensordot/GatherV2GatherV2!dense_17/Tensordot/Shape:output:0 dense_17/Tensordot/free:output:0)dense_17/Tensordot/GatherV2/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:d
"dense_17/Tensordot/GatherV2_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_17/Tensordot/GatherV2_1GatherV2!dense_17/Tensordot/Shape:output:0 dense_17/Tensordot/axes:output:0+dense_17/Tensordot/GatherV2_1/axis:output:0*
Taxis0*
Tindices0*
Tparams0*
_output_shapes
:b
dense_17/Tensordot/ConstConst*
_output_shapes
:*
dtype0*
valueB: �
dense_17/Tensordot/ProdProd$dense_17/Tensordot/GatherV2:output:0!dense_17/Tensordot/Const:output:0*
T0*
_output_shapes
: d
dense_17/Tensordot/Const_1Const*
_output_shapes
:*
dtype0*
valueB: �
dense_17/Tensordot/Prod_1Prod&dense_17/Tensordot/GatherV2_1:output:0#dense_17/Tensordot/Const_1:output:0*
T0*
_output_shapes
: `
dense_17/Tensordot/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_17/Tensordot/concatConcatV2 dense_17/Tensordot/free:output:0 dense_17/Tensordot/axes:output:0'dense_17/Tensordot/concat/axis:output:0*
N*
T0*
_output_shapes
:�
dense_17/Tensordot/stackPack dense_17/Tensordot/Prod:output:0"dense_17/Tensordot/Prod_1:output:0*
N*
T0*
_output_shapes
:�
dense_17/Tensordot/transpose	Transposedense_16/Relu:activations:0"dense_17/Tensordot/concat:output:0*
T0*+
_output_shapes
:����������
dense_17/Tensordot/ReshapeReshape dense_17/Tensordot/transpose:y:0!dense_17/Tensordot/stack:output:0*
T0*0
_output_shapes
:�������������������
dense_17/Tensordot/MatMulMatMul#dense_17/Tensordot/Reshape:output:0)dense_17/Tensordot/ReadVariableOp:value:0*
T0*'
_output_shapes
:���������d
dense_17/Tensordot/Const_2Const*
_output_shapes
:*
dtype0*
valueB:b
 dense_17/Tensordot/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : �
dense_17/Tensordot/concat_1ConcatV2$dense_17/Tensordot/GatherV2:output:0#dense_17/Tensordot/Const_2:output:0)dense_17/Tensordot/concat_1/axis:output:0*
N*
T0*
_output_shapes
:�
dense_17/TensordotReshape#dense_17/Tensordot/MatMul:product:0$dense_17/Tensordot/concat_1:output:0*
T0*+
_output_shapes
:����������
dense_17/BiasAdd/ReadVariableOpReadVariableOp(dense_17_biasadd_readvariableop_resource*
_output_shapes
:*
dtype0�
dense_17/BiasAddBiasAdddense_17/Tensordot:output:0'dense_17/BiasAdd/ReadVariableOp:value:0*
T0*+
_output_shapes
:���������l
IdentityIdentitydense_17/BiasAdd:output:0^NoOp*
T0*+
_output_shapes
:����������
NoOpNoOp ^dense_15/BiasAdd/ReadVariableOp"^dense_15/Tensordot/ReadVariableOp ^dense_16/BiasAdd/ReadVariableOp"^dense_16/Tensordot/ReadVariableOp ^dense_17/BiasAdd/ReadVariableOp"^dense_17/Tensordot/ReadVariableOp*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0*(
_construction_contextkEagerRuntime*6
_input_shapes%
#:���������: : : : : : 2B
dense_15/BiasAdd/ReadVariableOpdense_15/BiasAdd/ReadVariableOp2F
!dense_15/Tensordot/ReadVariableOp!dense_15/Tensordot/ReadVariableOp2B
dense_16/BiasAdd/ReadVariableOpdense_16/BiasAdd/ReadVariableOp2F
!dense_16/Tensordot/ReadVariableOp!dense_16/Tensordot/ReadVariableOp2B
dense_17/BiasAdd/ReadVariableOpdense_17/BiasAdd/ReadVariableOp2F
!dense_17/Tensordot/ReadVariableOp!dense_17/Tensordot/ReadVariableOp:S O
+
_output_shapes
:���������
 
_user_specified_nameinputs"�L
saver_filename:0StatefulPartitionedCall_1:0StatefulPartitionedCall_28"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*�
serving_default�
M
dense_15_input;
 serving_default_dense_15_input:0���������@
dense_174
StatefulPartitionedCall:0���������tensorflow/serving/predict:�M
�
layer_with_weights-0
layer-0
layer_with_weights-1
layer-1
layer_with_weights-2
layer-2
	optimizer
	variables
trainable_variables
regularization_losses
	keras_api
	__call__
*
&call_and_return_all_conditional_losses
_default_save_signature

signatures"
_tf_keras_sequential
�

kernel
bias
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses"
_tf_keras_layer
�

kernel
bias
	variables
trainable_variables
regularization_losses
	keras_api
__call__
*&call_and_return_all_conditional_losses"
_tf_keras_layer
�

kernel
bias
	variables
 trainable_variables
!regularization_losses
"	keras_api
#__call__
*$&call_and_return_all_conditional_losses"
_tf_keras_layer
�
%iter
	&decay
'learning_rate
(momentum
)rho	rmsD	rmsE	rmsF	rmsG	rmsH	rmsI"
	optimizer
J
0
1
2
3
4
5"
trackable_list_wrapper
J
0
1
2
3
4
5"
trackable_list_wrapper
 "
trackable_list_wrapper
�
*non_trainable_variables

+layers
,metrics
-layer_regularization_losses
.layer_metrics
	variables
trainable_variables
regularization_losses
	__call__
_default_save_signature
*
&call_and_return_all_conditional_losses
&
"call_and_return_conditional_losses"
_generic_user_object
�2�
/__inference_sequential_5_layer_call_fn_38308068
/__inference_sequential_5_layer_call_fn_38308229
/__inference_sequential_5_layer_call_fn_38308246
/__inference_sequential_5_layer_call_fn_38308168�
���
FullArgSpec1
args)�&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�2�
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308330
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308414
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308187
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308206�
���
FullArgSpec1
args)�&
jself
jinputs

jtraining
jmask
varargs
 
varkw
 
defaults�
p 

 

kwonlyargs� 
kwonlydefaults� 
annotations� *
 
�B�
#__inference__wrapped_model_38307935dense_15_input"�
���
FullArgSpec
args� 
varargsjargs
varkwjkwargs
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
,
/serving_default"
signature_map
!:2dense_15/kernel
:2dense_15/bias
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
�
0non_trainable_variables

1layers
2metrics
3layer_regularization_losses
4layer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses"
_generic_user_object
�2�
+__inference_dense_15_layer_call_fn_38308442�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
F__inference_dense_15_layer_call_and_return_conditional_losses_38308473�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
!:2dense_16/kernel
:2dense_16/bias
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
�
5non_trainable_variables

6layers
7metrics
8layer_regularization_losses
9layer_metrics
	variables
trainable_variables
regularization_losses
__call__
*&call_and_return_all_conditional_losses
&"call_and_return_conditional_losses"
_generic_user_object
�2�
+__inference_dense_16_layer_call_fn_38308482�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
F__inference_dense_16_layer_call_and_return_conditional_losses_38308513�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
!:2dense_17/kernel
:2dense_17/bias
.
0
1"
trackable_list_wrapper
.
0
1"
trackable_list_wrapper
 "
trackable_list_wrapper
�
:non_trainable_variables

;layers
<metrics
=layer_regularization_losses
>layer_metrics
	variables
 trainable_variables
!regularization_losses
#__call__
*$&call_and_return_all_conditional_losses
&$"call_and_return_conditional_losses"
_generic_user_object
�2�
+__inference_dense_17_layer_call_fn_38308522�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
�2�
F__inference_dense_17_layer_call_and_return_conditional_losses_38308552�
���
FullArgSpec
args�
jself
jinputs
varargs
 
varkw
 
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
:	 (2RMSprop/iter
: (2RMSprop/decay
: (2RMSprop/learning_rate
: (2RMSprop/momentum
: (2RMSprop/rho
 "
trackable_list_wrapper
5
0
1
2"
trackable_list_wrapper
'
?0"
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
�B�
&__inference_signature_wrapper_38308433dense_15_input"�
���
FullArgSpec
args� 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs� 
kwonlydefaults
 
annotations� *
 
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_dict_wrapper
N
	@total
	Acount
B	variables
C	keras_api"
_tf_keras_metric
:  (2total
:  (2count
.
@0
A1"
trackable_list_wrapper
-
B	variables"
_generic_user_object
+:)2RMSprop/dense_15/kernel/rms
%:#2RMSprop/dense_15/bias/rms
+:)2RMSprop/dense_16/kernel/rms
%:#2RMSprop/dense_16/bias/rms
+:)2RMSprop/dense_17/kernel/rms
%:#2RMSprop/dense_17/bias/rms�
#__inference__wrapped_model_38307935~;�8
1�.
,�)
dense_15_input���������
� "7�4
2
dense_17&�#
dense_17����������
F__inference_dense_15_layer_call_and_return_conditional_losses_38308473d3�0
)�&
$�!
inputs���������
� ")�&
�
0���������
� �
+__inference_dense_15_layer_call_fn_38308442W3�0
)�&
$�!
inputs���������
� "�����������
F__inference_dense_16_layer_call_and_return_conditional_losses_38308513d3�0
)�&
$�!
inputs���������
� ")�&
�
0���������
� �
+__inference_dense_16_layer_call_fn_38308482W3�0
)�&
$�!
inputs���������
� "�����������
F__inference_dense_17_layer_call_and_return_conditional_losses_38308552d3�0
)�&
$�!
inputs���������
� ")�&
�
0���������
� �
+__inference_dense_17_layer_call_fn_38308522W3�0
)�&
$�!
inputs���������
� "�����������
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308187xC�@
9�6
,�)
dense_15_input���������
p 

 
� ")�&
�
0���������
� �
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308206xC�@
9�6
,�)
dense_15_input���������
p

 
� ")�&
�
0���������
� �
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308330p;�8
1�.
$�!
inputs���������
p 

 
� ")�&
�
0���������
� �
J__inference_sequential_5_layer_call_and_return_conditional_losses_38308414p;�8
1�.
$�!
inputs���������
p

 
� ")�&
�
0���������
� �
/__inference_sequential_5_layer_call_fn_38308068kC�@
9�6
,�)
dense_15_input���������
p 

 
� "�����������
/__inference_sequential_5_layer_call_fn_38308168kC�@
9�6
,�)
dense_15_input���������
p

 
� "�����������
/__inference_sequential_5_layer_call_fn_38308229c;�8
1�.
$�!
inputs���������
p 

 
� "�����������
/__inference_sequential_5_layer_call_fn_38308246c;�8
1�.
$�!
inputs���������
p

 
� "�����������
&__inference_signature_wrapper_38308433�M�J
� 
C�@
>
dense_15_input,�)
dense_15_input���������"7�4
2
dense_17&�#
dense_17���������