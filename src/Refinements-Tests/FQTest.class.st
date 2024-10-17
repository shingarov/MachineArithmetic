Class {
	#name : #FQTest,
	#superclass : #TestCase,
	#category : #'Refinements-Tests'
}

{ #category : #proving }
FQTest >> proveNeg: txt [
	| q |
	q := FQParser parse: txt.
	self deny: q isPetitFailure.
	self deny: q solve isSafe
]

{ #category : #proving }
FQTest >> provePos: txt [
	| q |
	q := FQParser parse: txt.
	self deny: q isPetitFailure.
	self assert: q solve isSafe
]
