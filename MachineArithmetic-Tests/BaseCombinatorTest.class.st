Class {
	#name : #BaseCombinatorTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests-SMT'
}

{ #category : #tests }
BaseCombinatorTest >> testSKKisYourself [
	| K anything |
	K := [ :x | [ :y | x ] ].
	anything := 42.
	self assert: ((K S) value: K value: anything) == anything


]
