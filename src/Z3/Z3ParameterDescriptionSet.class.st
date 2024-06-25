Class {
	#name : #Z3ParameterDescriptionSet,
	#superclass : #Z3ReferenceCountedObject,
	#instVars : [
		'descrArray'
	],
	#category : #'Z3-Core'
}

{ #category : #accessing }
Z3ParameterDescriptionSet >> at: index [
	| descr |

	index isInteger ifFalse: [ self indexNotInteger: index. ^ nil ].
	(index between: 1 and: self size) ifFalse: [ self subscriptBoundsError: index. ^ self ].

	descr := descrArray at: index.
	descr isNil ifTrue: [
		| name |

		name := Z3 param_descrs_get_name: ctx _:self _: index - 1.
		descr := Z3ParameterDescription
					name: name
					kind: (Z3 param_descrs_get_kind: ctx _:self _: name)
					documentation:  (Z3 param_descrs_get_documentation: ctx _:self _: name).
		descrArray at: index put: descr.
	].
	^ descr.
]

{ #category : #accessing }
Z3ParameterDescriptionSet >> at: index put: value [
	self shouldNotImplement.
]

{ #category : #'ref-counting' }
Z3ParameterDescriptionSet >> decRef [
	Z3 param_descrs_dec_ref: ctx _: self
]

{ #category : #'ref-counting' }
Z3ParameterDescriptionSet >> incRef [
	Z3 param_descrs_inc_ref: ctx _: self
]

{ #category : #'initialization & release' }
Z3ParameterDescriptionSet >> initializeWithAddress: anExternalAddress context: aZ3Context [
	super initializeWithAddress: anExternalAddress context: aZ3Context.
	descrArray := Array new: self size.
]

{ #category : #accessing }
Z3ParameterDescriptionSet >> size [
	^ Z3 param_descrs_size: ctx _: self
]

{ #category : #converting }
Z3ParameterDescriptionSet >> toString [
	^ Z3 param_descrs_to_string: ctx _: self
]
