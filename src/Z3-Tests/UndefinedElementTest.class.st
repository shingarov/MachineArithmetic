Class {
	#name : #UndefinedElementTest,
	#superclass : #TestCase,
	#category : #'Z3-Tests'
}

{ #category : #tests }
UndefinedElementTest >> testDifferentLengthBitVector [
	| BV32 BV64 e₁ e₂ |
	BV32 := BitVector///32.
	BV64 := BitVector///64.
	e₁ := BV32 undefinedElement.
	e₂ := BV64 undefinedElement.
	self deny: e₁ equals: e₂
]

{ #category : #tests }
UndefinedElementTest >> testSameBitVector [
	| BV32 e₁ e₂ |
	BV32 := BitVector///32.
	e₁ := BV32 undefinedElement.
	e₂ := BV32 undefinedElement.
	self assert: e₁ == e₂
]

{ #category : #tests }
UndefinedElementTest >> testZZ [
	| Z e₁ e₂ |
	Z := Int sort.
	e₁ := Z undefinedElement.
	e₂ := Z undefinedElement.
	self assert: e₁ == e₂
]
