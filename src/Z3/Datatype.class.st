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

{ #category : #testing }
Datatype >> isDatatype [
	^ true

]

{ #category : #accessing }
Datatype >> set: field to: value [
	"Return a *new* datatype instance with given field set given value. 
	 All other field values remain unchanged.
	
	 If this datatype has multiple constructors and there's a mismatch
	 (that is - the constructor that created receiver does not specify given 
	 field), the receiver is silently returned *unchanged*.
	
	 If multiple constructors define the a 'field' with the same name, then 
	 this method throws an error."

	| accessor |
	
	accessor := self sort accessorNamed: field.
	^ Z3 datatype_update_field: ctx _: accessor _: self _: (accessor range cast: value)
]

{ #category : #converting }
Datatype >> toDatatype: aZ3Sort [
	self sort == aZ3Sort ifFalse: [ ^self error: 'Cannot coerce' ].
	^self
]
