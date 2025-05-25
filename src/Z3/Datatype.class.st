Class {
	#name : #Datatype,
	#superclass : #Z3Node,
	#category : #'Z3-Core'
}

{ #category : #accessing }
Datatype >> get: aString [
	"Return given field's value. Note. that if multiple constructors define 
	 the 'field' with the same name, then this method throws an error. In 
	 that case, you may need to lookup the accessor and use it directly."

	| accessor |
	
	accessor := self sort accessorNamed: aString.
	^accessor value: self
]

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

{ #category : #accessing }
Datatype >> updateFieldNamed: field to: value [
	"Return a *new* datatype instance with given field set given value. 
	 All other field values remain unchanged.
	
	 If this datatype has multiple constructors and there's a mismatch
	 (that is - the constructor that created receiver does not specify given 
	 field), the receiver is silently returned *unchanged*.
	
	 If multiple constructors define the a 'field' with the same name, then 
	 this method throws an error."

	| accessor valueAST |
	accessor := self sort accessorNamed: field.
	valueAST := accessor range cast: value.
	^ Z3 datatype_update_field: ctx _: accessor _: self _: valueAST
]
