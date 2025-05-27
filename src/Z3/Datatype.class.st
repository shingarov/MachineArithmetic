Class {
	#name : #Datatype,
	#superclass : #Z3Node,
	#category : #'Z3-Core'
}

{ #category : #accessing }
Datatype >> is: aConstructorNameString [ 
	"Apply the recognizer for aConstructorNameString to the receiver."
	^ (self sort recognizerFor: aConstructorNameString) value: self
]

{ #category : #testing }
Datatype >> isDatatype [
	^ true

]

{ #category : #converting }
Datatype >> toDatatype: aZ3Sort [
	self sort == aZ3Sort ifFalse: [ ^self error: 'Cannot coerce' ].
	^self
]

{ #category : #accessing }
Datatype >> update: fieldAccessorFuncDecl to: newValue [
	^ Z3 datatype_update_field: ctx _: fieldAccessorFuncDecl _: self _: newValue
]
