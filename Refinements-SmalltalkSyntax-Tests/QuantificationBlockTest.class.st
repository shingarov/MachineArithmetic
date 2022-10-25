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
	^[ ∀x ∈ Z [x>0] | x >= 0 ]'
	classified: #generated 
]

{ #category : #tests }
QuantificationBlockTest >> generateMethodH [
	self class compile: 'h
	| Z |
	Z := Int sort.
	^[ ⋆κ(Z×Z) | κ value: 1 value: 2  ]'
	classified: #generated 
]

{ #category : #tests }
QuantificationBlockTest >> generateMethodL [
	self class compile: 'l
	^[ :x | x > 0 ]'
	classified: #generated 
]

{ #category : #tests }
QuantificationBlockTest >> generateTwoH [
	self class compile: 'h2
	| Z R |
	Z := Int sort. R := Real sort.
	^[ ⋆κ1(Z) ⋆κ2(R) | κ value: 1 value: 2  ]'
	classified: #generated 
]

{ #category : #tests }
QuantificationBlockTest >> testForall [
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

{ #category : #tests }
QuantificationBlockTest >> testHorn [
	| horn hvar block |
	"Compile:"
	self generateMethodH.
	self assert: (self class>>#h) selector equals: #h.
	"Run:"
	horn := self h.
	hvar := horn hvar.
	block := horn block.
	"Evaluate:"
	self assert: (block value: [ :x :y | x+y ]) equals: 3.
	"Clean up:"
	self class removeSelector: #h.
]

{ #category : #tests }
QuantificationBlockTest >> testLambda [
	| l |
	"Compile:"
	self generateMethodL.
	self assert: (self class>>#l) selector equals: #l.
	"Run:"
	l := self l.  "l is now the BlockClosure"
	self assert: l argumentNames equals: #(x).
	"Evaluate:"
	self assert: (l value: 1).
	self deny:   (l value: -1).
	"Clean up:"
	self class removeSelector: #l.
]

{ #category : #tests }
QuantificationBlockTest >> testTwoHorns [
	| horn hvar block |
	"Compile:"
	self generateTwoH.
	self assert: (self class>>#h2) selector equals: #h2.
	"Run:"
	horn := self h2.
	hvar := horn hvar.
	block := horn block.
	"Evaluate:"
	self assert: (block value: [ :x :y | x+y ]) equals: 3.
	"Clean up:"
	self class removeSelector: #h2.
"QuantificationBlockTest removeSelector: #h2 "
]
