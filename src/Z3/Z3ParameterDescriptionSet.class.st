Class {
	#name : #Z3ParameterDescriptionSet,
	#superclass : #Z3ReferenceCountedObject,
	#category : #'Z3-Core'
}

{ #category : #'ref-counting' }
Z3ParameterDescriptionSet >> decRef [
	Z3 param_descrs_dec_ref: ctx _: self
]

{ #category : #'ref-counting' }
Z3ParameterDescriptionSet >> incRef [
	Z3 param_descrs_inc_ref: ctx _: self
]
