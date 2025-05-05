Class {
	#name : #Z3Constructor,
	#superclass : #Z3ContextedObject,
	#instVars : [
		'numFields'
	],
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
Z3Constructor class >> name: constructorName recognizer: recognizerName fields: fields referencing: sortRefs [
	| ctx |

	fields detect: [:nameAndSort |
		| sort |
		
		sort := nameAndSort value.
		sort notNil ifTrue:[ ctx := sort ctx. true ] ifFalse:[false] 
	] ifNone: [ ctx := Z3Context current ].

	^(ctx
				mkConstructor: constructorName
				recognizer: recognizerName
				fields: fields
				referencing: sortRefs) numFields: fields size
]

{ #category : #'initialization & release' }
Z3Constructor >> delete [
	Z3 del_constructor: ctx _: self
]

{ #category : #accessing }
Z3Constructor >> numFields [
	"^Z3 constructor_num_fields: ctx _: self"
	
	"Hack around the Z3 version problem"
	^numFields
]

{ #category : #'stupid hacks' }
Z3Constructor >> numFields: n [
	numFields := n.
	^self
]

{ #category : #accessing }
Z3Constructor >> query [
	^ctx queryConstructor: self
]
