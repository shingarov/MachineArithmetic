Class {
	#name : #HornTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
HornTest >> proveNeg: txt [
	| q |
	q := NNFParser parse: txt.
	self deny: q isPetitFailure.
	self assert: q solve equals: #Unsafe 
]

{ #category : #'tests - safety' }
HornTest >> provePos: txt [
	| q |
	q := NNFParser parse: txt.
	self deny: q isPetitFailure.
	self assert: q solve equals: #Safe
	
]
