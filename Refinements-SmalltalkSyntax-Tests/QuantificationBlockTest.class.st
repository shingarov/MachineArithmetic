Class {
	#name : #QuantificationBlockTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-SmalltalkSyntax-Tests'
}

{ #category : #tests }
QuantificationBlockTest >> generateMethodD [
	self class compile: 'd
	| Z |
	Z := Int sort.
	^[ ∀x ∈ (Z) | [ ∀y ∈ (Z) [y>x] | y>0 ] ] '
	classified: #generated
]

{ #category : #tests }
QuantificationBlockTest >> generateMethodF [
	self class compile: 'f
	| Z |
	Z := Int sort.
	^[ ∀x ∈ (Z) [x>0] | x >= 0 ]'
	classified: #generated 
]

{ #category : #tests }
QuantificationBlockTest >> generateMethodH [
	self class compile: 'h
	| Z |
	Z := Int sort.
	^[ ⋆k0(Z) | [ ∀x ∈ Z [k0 value: x] | x>10 ]  ]'
	classified: #generated 
]

{ #category : #tests }
QuantificationBlockTest >> generateMethodL [
	self class compile: 'l
	^[ :x | x > 0 ]'
	classified: #generated 
]

{ #category : #tests }
QuantificationBlockTest >> generateMethodN [
	self class compile: 'n
	| Z |
	Z := Int sort.
	^[ ∀x ∈ (Z) | [ ∀y ∈ (Z) | x>y ] ]'
	classified: #generated 
]

{ #category : #tests }
QuantificationBlockTest >> generateTwoH [
	self class compile: 'h2
	| Z R |
	Z := Int sort. R := Real sort.
	^[ ⋆k1(Z) ⋆k2(R) |
		[ ∀i∈Z | [ ∀x∈R | (k1 value: i) & (k2 value: x) ] ]
	]'
	classified: #generated 
]

{ #category : #tests }
QuantificationBlockTest >> testDependentForall [
	| outerForall innerForall |
	"Compile:"
	self generateMethodD.
	self assert: (self class>>#d) selector equals: #d.

	"Run:"
	outerForall := self d.
	self assert: outerForall bind x equals: 'x'.
	self assert: outerForall bind τ equals: Int sort.
	self assert: outerForall bind p z3bool isAST.
	self assert: outerForall bind p z3bool isBool.
	self assert: outerForall bind p z3bool isShortExpr.
	innerForall := outerForall p.
	self assert: innerForall bind x equals: 'y'.
	self assert: innerForall bind τ equals: Int sort.
	self assert: innerForall p pred z3bool isAST.
	self assert: innerForall p pred z3bool isBool.
	self deny:   innerForall bind p z3bool isShortExpr.
	
	"Clean up:"
	self class removeSelector: #d.
]

{ #category : #tests }
QuantificationBlockTest >> testForall [
	| forall |
	"Compile:"
	self generateMethodF.
	self assert: (self class>>#f) selector equals: #f.

	"Run:"
	forall := self f.
	self assert: forall bind x equals: 'x'.
	self assert: forall bind τ equals: Int sort.
	self assert: forall bind p z3bool isAST.
	self assert: forall bind p z3bool isBool.
	self assert: forall p pred z3bool isAST.
	self assert: forall p pred z3bool isBool.

	"Clean up:"
	self class removeSelector: #f.
]

{ #category : #tests }
QuantificationBlockTest >> testHorn [
	| horn |
	"Compile:"
	self generateMethodH.
	self assert: (self class>>#h) selector equals: #h.
	"Run:"
	horn := self h.
	self assert: (horn isKindOf: HornQuery).
	"the following line is commented out because,
	 even though it should of course pass, this test
	 is only concerned with compilation."
	"self assert: horn solve equals: #Safe."

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
QuantificationBlockTest >> testNestedForall [
	| outer inner |
	"Compile:"
	self generateMethodN.
	self assert: (self class>>#n) selector equals: #n.
	"Run:"
	outer := self n.
	self assert: (outer isKindOf: CstrAll).
	inner := outer p.
	self assert: (inner isKindOf: CstrAll).

	"Clean up:"
	self class removeSelector: #n.
]

{ #category : #tests }
QuantificationBlockTest >> testTwoHorns [
	| horn hvar block |
	"Compile:"
	self generateTwoH.
	self assert: (self class>>#h2) selector equals: #h2.
	"Run:"
	horn := self h2.
	self assert: (horn isKindOf: HornQuery).
	self assert: (horn qCstr first isKindOf: CstrAll).

	"Clean up:"
	self class removeSelector: #h2.
"QuantificationBlockTest removeSelector: #h2 "
]
