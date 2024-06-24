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
Z3ParameterSet >> at: key [
	"Z3ParameterSet does not support retrieval. Use #toString to look 
	 inside for debugging purposes."

	self shouldNotImplement.
]

{ #category : #API }
Z3ParameterSet >> at: key put: val [
	"Add a parameter `key` with value `val` to the parameter set.

	 `key` must be either string or Z3Symbol.
	 `val` must be either integer <0. 16FFFFFFFF>, double, boolean or Z3Symbol (string).

	 Returns `val` (like Smalltalk collections).
	"

	(val == true or:[val == false]) ifTrue: [
		Z3 params_set_bool: ctx _:self _:key toZ3Symbol _:val.
		^ val.
	].
	val isFloat ifTrue: [ 
		Z3 params_set_double: ctx _:self _:key toZ3Symbol _:val.
		^ val.
	].
	val isInteger ifTrue: [ 
		(val between: 0 and: 16rFFFFFFFF) ifTrue: [ 
			Z3 params_set_uint: ctx _:self _:key toZ3Symbol _:val.
		] ifFalse: [ 
			self error: 'Integer value out of range'.
		].
		^ val.
	].
	(val isString or:[val isZ3Symbol]) ifTrue: [ 
		Z3 params_set_symbol: ctx _:self _:key toZ3Symbol _:val toZ3Symbol.
		^ val.
	].

	self error: 'Invalid value'
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
Z3ParameterSet >> toString [
	^ Z3 params_to_string: ctx _: self
]

{ #category : #converting }
Z3ParameterSet >> toZ3ParameterSet [
	^self
]
