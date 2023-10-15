"
I represent a Cartesian product of zero or more terms.
For example, ℤ × ℤ is the set of all ordered-pairs of integers.
Product is a monoid under #×, with (Product new) acting as the unit,
and ∀A,B,C. A × (B × C) = (A × B) × C.
"
Class {
	#name : #Product,
	#superclass : #Array,
	#type : #variable,
	#category : #'MachineArithmetic-MathNotation'
}

{ #category : #converting }
Product >> asArray [
	^Array withAll: self
]

{ #category : #Z3 }
Product >> mkRelationNamed: aString [ 
	^aString functionFrom: self to: Bool sort
]

{ #category : #'as yet unclassified' }
Product >> nameForHomoArray [
	^self printString
]

{ #category : #printing }
Product >> printOn: aStream [
	aStream nextPut: $(.
	self do: [:element | aStream print: element] separatedBy: [ aStream
		space;
		nextPut: Character multiplicationSign;
		space ].
	aStream nextPut: $)
]

{ #category : #converting }
Product >> toProduct [
	^self
]

{ #category : #monoid }
Product >> × [ C
	"The operation of the 'Product' monoid.
	For example, if the receiver is something like A×B, answer A×B×C.
	"
	^self, C toProduct
]

{ #category : #comparing }
Product >> ≅ [ rhs 
	self = rhs ifTrue: [^true].
	^self = (Product with: rhs)
]

{ #category : #monoid }
Product >> ⨰ [ C
	"Non-associative version of #×.
	 This is useful, for example, when deserializing data coming on the wire
	 from ML, because in ML, (string*string)*string ≠ string*(string*string)."
	^self, (Product with: C)
]
