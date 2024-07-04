"
foldl op a bs
  is actually
bs inject: a into: op

Cf. http://zvon.org/other/haskell/Outputprelude/foldl_f.html
This class contains the 5 examples from the above url.

This test comes handy when looking at a a bunch of foldls and just wanting to write the same in Smalltalk.
"
Class {
	#name : #FoldlIsInjectTest,
	#superclass : #TestCase,
	#pools : [
		'Combinators'
	],
	#category : #'MathNotation-Tests'
}

{ #category : #tests }
FoldlIsInjectTest >> test1 [
	self assert: ({ 4 . 2 . 4 } inject: 64 into: [ :x :y | x/y ]) equals: 2
]

{ #category : #tests }
FoldlIsInjectTest >> test2 [
	self assert: (#() inject: 3 into: [ :x :y | x/y ]) equals: 3
]

{ #category : #tests }
FoldlIsInjectTest >> test3 [
	self assert: ({1 . 2 . 3 . 4} inject: 5 into: [ :x :y | x max: y ]) equals: 5
]

{ #category : #tests }
FoldlIsInjectTest >> test4 [
	self assert: ({1 . 2 . 3 . 4 . 5 . 6 . 7} inject: 5 into: [ :x :y | x max: y ]) equals: 7
]

{ #category : #tests }
FoldlIsInjectTest >> test5 [
	self assert: ({1 . 2 . 3} inject: 4 into: [ :x :y | 2*x + y ]) equals: 43
]

{ #category : #tests }
FoldlIsInjectTest >> testFactorial0 [
	self
		assert: 0 factorialHylomorphically
		equals: 1
]

{ #category : #tests }
FoldlIsInjectTest >> testFactorial5 [
	self
		assert: 5 factorialHylomorphically
		equals: 120
]

{ #category : #tests }
FoldlIsInjectTest >> testPerformCurryingOrder1 [
	| r |
	r := {1.0 . 2.0 . 3.0 . 4.0 . 5.0}
		inject: 1000.0
		into: #/.
	self assert: (r between: 8.3 and: 8.4)
]

{ #category : #tests }
FoldlIsInjectTest >> testPerformCurryingOrder2 [
	self
		assert: ({1 . 2 . 3 . 4 . 5} inject: 0 into: #-)
		equals: -15
]

{ #category : #tests }
FoldlIsInjectTest >> testSizeCatamorphically [
	| size |
	size := #(a b c) inject: 0 into: (□+1)⋅K. "indeed works for any Foldable"
	self assert: size equals: 3
]
