Class {
	#name : #QuantifierNotationTest,
	#superclass : #MathNotationTest,
	#category : #'MachineArithmetic-MathNotation-Tests'
}

{ #category : #tests }
QuantifierNotationTest >> testBindNotation [
	| bind |
	bind := ∀ z ∈ ℤ | [ :x | x > 1 ].
	self halt.
]

{ #category : #tests }
QuantifierNotationTest >> testForAll [
	| fa |
	fa := ∀ z ∈ ℤ.
	
]
