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
	#category : #Refinements
}

{ #category : #comparing }
Product >> = rhs [
	"An object is equal to its first degree.
	Our modest implementation implementation only works in the category of Z3 sorts and functions between them."
	(rhs respondsTo: #toProduct) ifTrue: [^super = rhs toProduct].
	^super = rhs
	
]

{ #category : #converting }
Product >> asArray [
	^Array withAll: self
]

{ #category : #comparing }
Product >> hash [
	self size = 1 ifTrue: [^self first hash].
	^super hash
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
