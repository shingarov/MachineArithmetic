Class {
	#name : #FxExprTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Doodles'
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
	x := EVar of: 'x'.
	y := EVar of: 'y'.
	e := EApp mkEApp: 'f' args: { x.y }.
	self assert: (e isKindOf: EApp).
	inner := e expr.
	self assert: (inner isKindOf: EApp).
	self assert: inner expr equals: (EVar of: 'f').
	self assert: inner imm  equals: (EVar of: 'x').
]

{ #category : #tests }
FxExprTest >> testSplitEApp0 [
	| x split |
	x := EVar of: 'x'.
	split := x splitEApp.
	self assert: split key equals: (EVar of: 'x').
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
	x := EVar of: 'x'.
	e := EApp mkEApp: 'f' args: { x }.
	split := e splitEApp.
	self assert: split key equals: (EVar of: 'f').
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
	x := EVar of: 'x'.
	y := EVar of: 'y'.
	e := EApp mkEApp: 'f' args: { x.y }.
	split := e splitEApp.
	self assert: split key equals: (EVar of: 'f').
	args := split value.
	self assert: args size equals: 2.
	self assert: args first equals: x.
	self assert: args second equals: y.
]
