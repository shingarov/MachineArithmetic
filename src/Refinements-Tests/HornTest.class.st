Class {
	#name : #HornTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Tests'
}

{ #category : #proving }
HornTest >> proveNeg: txt [
	| q |
	q := NNFParser parse: txt.
	self deny: q isPetitFailure.
	self deny: q solve isSafe
]

{ #category : #proving }
HornTest >> provePos: txt [
	| q |
	q := NNFParser parse: txt.
	self deny: q isPetitFailure.
	self assert: q solve isSafe
	
]
