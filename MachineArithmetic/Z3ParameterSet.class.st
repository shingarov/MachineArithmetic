Class {
	#name : #Z3ParameterSet,
	#superclass : #Z3ReferenceCountedObject,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Z3ParameterSet class >> on: aZ3Context [
	^ Z3 mk_params: aZ3Context

]

{ #category : #API }
Z3ParameterSet >> at: aZ3Symbol putUint: anInteger [
	Z3 params_set_uint: ctx _: self _: aZ3Symbol _: anInteger

]

{ #category : #'ref-counting' }
Z3ParameterSet >> decRef [
	Z3 params_dec_ref: ctx _: self

]

{ #category : #'ref-counting' }
Z3ParameterSet >> incRef [
	Z3 params_inc_ref: ctx _: self

]

{ #category : #API }
Z3ParameterSet >> paramsToString [
	^ Z3 params_to_string: ctx _: self

]
