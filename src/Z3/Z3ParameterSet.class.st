Class {
	#name : #Z3ParameterSet,
	#superclass : #Z3ReferenceCountedObject,
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
Z3ParameterSet class >> new [
	^ Z3 mk_params: Z3Context current

]

{ #category : #'instance creation' }
Z3ParameterSet class >> on: aZ3Context [
	^ Z3 mk_params: aZ3Context

]

{ #category : #API }
Z3ParameterSet >> at: key putBoolean: val [
	Z3 params_set_bool: ctx _: self _: key toZ3Symbol _: val
]

{ #category : #API }
Z3ParameterSet >> at: key putString: value [
	Z3 params_set_symbol: ctx _: self
		_: key toZ3Symbol
		_: value toZ3Symbol
]

{ #category : #API }
Z3ParameterSet >> at: key putUint: anInteger [
	Z3 params_set_uint: ctx _: self
		_: key toZ3Symbol
		_: anInteger

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

{ #category : #converting }
Z3ParameterSet >> toZ3ParameterSet [
	^self
]
