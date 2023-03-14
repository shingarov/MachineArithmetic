Class {
	#name : #FxExprTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
FxExprTest >> testMkEApp [
"
ghci> let f = let f = dummyLoc (symbol 'f')
      let x = EVar 'x'
      let y = EVar 'y'
      let e = mkEApp f [ x, y ]
e -> EApp (EApp (EVar 'f') (EVar 'x')) (EVar 'y')
"
	| x y e inner |
	x := FxEVar of: 'x'.
	y := FxEVar of: 'y'.
	e := FxEApp mkEApp: 'f' args: { x.y }.
	self assert: (e isKindOf: FxEApp).
	inner := e expr.
	self assert: (inner isKindOf: FxEApp).
	self assert: inner expr equals: (FxEVar of: 'f').
	self assert: inner imm  equals: (FxEVar of: 'x').
]

{ #category : #tests }
FxExprTest >> testSplitEApp0 [
	| x split |
	x := FxEVar of: 'x'.
	split := x splitEApp.
	self assert: split key equals: (FxEVar of: 'x').
	self assert: split value equals: #().
]

{ #category : #tests }
FxExprTest >> testSplitEApp1 [
"
ghci> let f = let f = dummyLoc (symbol 'f')
      let x = (symbol EVar 'x')
      let e = mkEApp f [ x ]
e -> EApp (EVar 'f') (EVar 'x')
splitEApp e -> (EVar 'f', [EVar 'x'])
"
	| x e split args |
	x := FxEVar of: 'x'.
	e := FxEApp mkEApp: 'f' args: { x }.
	split := e splitEApp.
	self assert: split key equals: (FxEVar of: 'f').
	args := split value.
	self assert: args size equals: 1.
	self assert: args first equals: x.
]

{ #category : #tests }
FxExprTest >> testSplitEApp2 [
"
ghci> let f = let f = dummyLoc (symbol 'f')
      let x = EVar 'x'
      let y = EVar 'y'
      let e = mkEApp f [ x, y ]
e -> EApp (EApp (EVar 'f') (EVar 'x')) (EVar 'y')
"
	| x y e split args |
	x := FxEVar of: 'x'.
	y := FxEVar of: 'y'.
	e := FxEApp mkEApp: 'f' args: { x.y }.
	split := e splitEApp.
	self assert: split key equals: (FxEVar of: 'f').
	args := split value.
	self assert: args size equals: 2.
	self assert: args first equals: x.
	self assert: args second equals: y.
]
