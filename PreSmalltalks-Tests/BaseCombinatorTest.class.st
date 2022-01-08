Class {
	#name : #BaseCombinatorTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
BaseCombinatorTest >> testCompose [
	| plus1 double |
	plus1 := [ :x | x+1 ].
	double := [ :x | x*2 ].
	self assert: (plus1*double value: 42) equals: (42+1)*2.
	self assert: (double*plus1 value: 42) equals: (42*2)+1.

]

{ #category : #tests }
BaseCombinatorTest >> testSKKisYourself [
	| K anything |
	K := [ :x | [ :y | x ] ].
	anything := 42.
	self assert: ((K S) value: K value: anything) == anything


]
