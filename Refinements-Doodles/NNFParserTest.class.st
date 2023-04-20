Class {
	#name : #NNFParserTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Doodles'
}

{ #category : #tests }
NNFParserTest >> parse: aString [
	| parsed |
	parsed := NNFParser parse: aString.
	self deny: parsed isPetitFailure.
	^parsed
]

{ #category : #tests }
NNFParserTest >> testConstant [
	| parser fs |
	parser := NNFParser new productionAt: #constant .
	fs := parser parse: 'constant f (func(0, [Int;Int]))'.
	"fs := parser parse: 'constant f Int'."
	self deny: fs isPetitFailure.
	"fs in an unnamed FuncDecl"
	self assert: fs name  equals: ''.
	self assert: fs range equals: Int sort.
	self assert: fs domain equals: {Int sort. Int sort} "TODO: these should really be Products but that's in Refinements for now"
]

{ #category : #tests }
NNFParserTest >> testConstraintEmptyAnd [
	self parse: '
(constraint (and))
'
]

{ #category : #tests }
NNFParserTest >> testConstraintHead [
	self parse: '(constraint ((x>0)))'
]

{ #category : #tests }
NNFParserTest >> testConstraintWithAndHypothesis [
	self parse: '(constraint (forall ((x Int) (and ($k0 xx y) ($k1 z))) ((a=b))))'
]

{ #category : #tests }
NNFParserTest >> testConstraintWithDecidableHypothesis [
	| q c |
	q := self parse: '(constraint
   (forall ((x Int) ((x*3) < 1))
     ((a===b))))'.
	c := q qCstr first.
	self assert: c class equals: CstrAll.
	self assert: c bind x equals: 'x'.
	self assert: c bind τ equals: Int sort.
	self assert: c p pred text equals: 'a===b'.
	
]

{ #category : #tests }
NNFParserTest >> testConstraintWithVarAppConclusion [
	self parse: '
(constraint (forall ((x Int) (and)) (($k0 xx y))))
'
]

{ #category : #tests }
NNFParserTest >> testConstraintWithVarAppHypothesis [
	self parse: '(constraint (forall ((x Int) ($k0 xx y)) ((a=b))))'
]

{ #category : #tests }
NNFParserTest >> testFixpoint [
	self parse: '
(fixpoint "--eliminate=horn")
(fixpoint "--rewrite")
(fixpoint "--fuel=5")
'
]

{ #category : #tests }
NNFParserTest >> testFuncSort1 [
	| parser fs |
	parser := NNFParser new productionAt: #funcSort .
	fs := parser parse: '(0, [Int])'.
	self assert: fs equals: Int sort
]

{ #category : #tests }
NNFParserTest >> testFuncSort2 [
	| parser fs |
	parser := NNFParser new productionAt: #funcSort .
	fs := parser parse: '(0, [Int;Int])'.
	self deny: fs isPetitFailure.
]

{ #category : #tests }
NNFParserTest >> testFuncSort3 [
	| parser fs |
	parser := NNFParser new productionAt: #funcSort .
	fs := parser parse: '(1, [`a;`b;Int])'.
	self deny: fs isPetitFailure.
	"fs in an unnamed FuncDecl"
	self assert: fs printString  equals: 'FAbs 0 (a→(b→ℤ))'.
]

{ #category : #tests }
NNFParserTest >> testFuncSort4 [
	| parser fs |
	parser := NNFParser new productionAt: #funcSort .
	fs := parser parse: '(0, [(`l `a);Int])'.
	self deny: fs isPetitFailure.
	"because (`l `a) is not a Z3Sort, a function taking it, is an FFunc"
	self assert: fs printString equals: '((FApp l a)→ℤ)'.
]

{ #category : #tests }
NNFParserTest >> testKappaAppPredBind [
	| c |
	c := self parse: '
(constraint
  (forall ((z Int) ($k0 z))
    ((x > 100))))'.
	self assert: c qCstr first bind p var equals: 'k0'
]

{ #category : #tests }
NNFParserTest >> testKappaAppPredPred [
	| q c |
	q := self parse: '(constraint
    (forall ((z Int) (x > 1))
     (($k0 v))))'.
	c := q qCstr first.
	self assert: c p pred var equals: 'k0'
]

{ #category : #tests }
NNFParserTest >> testNestedAnd [
	self parse: '
(constraint (and (and) (and)))
'
]

{ #category : #tests }
NNFParserTest >> testTrivialTypeVar [
	self parse: '
(constraint
   (forall ((x `a) (Bool true))
    ((Bool true))))
'
]

{ #category : #tests }
NNFParserTest >> testTwoTypeVars [
	| nestedSort l a |
	nestedSort := NNFParser new sort end parse: '`l `a'.
	self assert: (nestedSort isKindOf: FApp).
	l := nestedSort s.  a := nestedSort t.
	self assert: l name getString equals: 'l'.
	self assert: a name getString equals: 'a'.
]

{ #category : #tests }
NNFParserTest >> testTwoTypeVars2 [
	| nestedSort l int |
	nestedSort := NNFParser new sort end parse: '`l int'.
	self assert: (nestedSort isKindOf: FApp).
	l := nestedSort s.  int := nestedSort t.
	self assert: l name getString equals: 'l'.
	self assert: int equals: Int sort.
]

{ #category : #tests }
NNFParserTest >> testTyconAppVar [
	self deny: (self parse: '(var $k ((`l `a)))') isPetitFailure
]

{ #category : #tests }
NNFParserTest >> testVar [
	self deny: (self parse: '(var $k ((int)))') isPetitFailure
]

{ #category : #tests }
NNFParserTest >> testVarSort [
	| var |
	var := NNFParser new varSort parse: '@(42)'.
	self assert: (var isKindOf: FVar).
	self assert: var i equals: 42
]
