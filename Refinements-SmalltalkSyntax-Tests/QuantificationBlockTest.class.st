Class {
	#name : #QuantificationBlockTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-SmalltalkSyntax-Tests'
}

{ #category : #tests }
QuantificationBlockTest >> generateMethodF [
	self class compile: 'f
	| Z |
	Z := Int sort.
	^[ ∀x ∈ (Z) | x > 0 ]'
	classified: #generated 
]

{ #category : #tests }
QuantificationBlockTest >> testCompileRunEvaluate [
	| forall |
	"Compile:"
	self generateMethodF.
	self assert: (self class>>#f) selector equals: #f.
	"Run:"
	forall := self f.
	self assert: forall x equals: 'x'.
	self assert: forall s equals: Int sort.
	self assert: forall r isNil.
	"Evaluate:"
	self assert: (forall b value: 1).
	self deny:   (forall b value: -1).
	"Clean up:"
	self class removeSelector: #f.
]
