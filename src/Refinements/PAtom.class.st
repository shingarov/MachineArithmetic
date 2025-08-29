"
data Expr =
          ...
          | PAtom  !Brel  !Expr !Expr

data Brel = Eq | Ne | Gt | Ge | Lt | Le | Ueq | Une
            deriving (Eq, Ord, Show, Data, Typeable, Generic)

Regarding Ueq see remark in Solution.hs about ""we use ~~ because the param
and value may have different sorts, see: tests/pos/kvar-param-poly-00.hs""
"
Class {
	#name : #PAtom,
	#superclass : #Expr,
	#instVars : [
		'brel',
		'x',
		'y'
	],
	#pools : [
		'Brel'
	],
	#category : #'Refinements-Core'
}

{ #category : #'instance creation' }
PAtom class >> brel: aSymbol x: x y: y [
	^self basicNew
		brel: aSymbol;
		x: x;
		y: y;
		yourself
]

{ #category : #'instance creation' }
PAtom class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
PAtom class >> normalizeBrelSelector: s [
	s = #eq:  ifTrue: [ ^#=== ].
	s = #iff: ifTrue: [ ^#<=> ].
	^(Brel classPool includes: s)
		ifTrue: [ s ]
		ifFalse: [ nil ]
]

{ #category : #comparing }
PAtom >> = another [
	self class = another class ifFalse: [ ^false ].
	^ (brel = another brel)
	& (x = another x)
	& (y = another y)
]

{ #category : #'term rewriting' }
PAtom >> accept: aVisitor [
	^self class
		brel: brel
		x: (x accept: aVisitor)
		y: (y accept: aVisitor)
]

{ #category : #accessing }
PAtom >> brel [
	^ brel
]

{ #category : #accessing }
PAtom >> brel: anObject [
	brel := anObject
]

{ #category : #'sort-checking' }
PAtom >> checkExpr: f [ 
	f checkRel: brel lhs: x rhs: y.
	^Bool sort
]

{ #category : #elaboration }
PAtom >> elab: f [
	(brel=Eq  or: (brel=Ne))  ifTrue: [ ^self elab__EqNe: f ].
	(brel=Ueq or: (brel=Une)) ifTrue: [ ^self elab__UeqUne: f ].
	^self elab__FallThrough: f
]

{ #category : #elaboration }
PAtom >> elabApplyStep: γ [ 
	^PAtom
		brel: brel
		x: (x elabApply: γ)
		y: (y elabApply: γ)
]

{ #category : #elaboration }
PAtom >> elab__EqNe: f [
"
elab f@(_,g) e@(PAtom eq e1 e2) | eq == Eq || eq == Ne = do
"
	| g tx ty tx′_ty′ tx′ ty′ x′ y′ x′′ y′′ |
	g := f env.
	tx := x checkExpr: g.
	ty := y checkExpr: g.
	"(t1',t2') <- unite g e  t1 t2 `withError` (errElabExpr e)"
	tx′_ty′ := g unite: self t1: tx t2: ty.
	tx′ := tx′_ty′ first.  ty′ := tx′_ty′ second.
	x′ := x elabAs: tx′ inElabEnv: f.
	y′ := y elabAs: ty′ inElabEnv: f.
	x′′ := x′ eCstAtom: tx′ inElabEnv: f.
	y′′ := y′ eCstAtom: ty′ inElabEnv: f.
	^{ (PAtom brel: brel x: x′′ y: y′′) . Bool sort }
]

{ #category : #elaboration }
PAtom >> elab__FallThrough: f [
"
elab f@(env,_) (PAtom r e1 e2)
"
	| x′ y′ computed |
	x′ := (x elab: f) first.
	y′ := (y elab: f) first.
	computed := x′ perform: brel with: y′.
	^{ computed . Bool sort }
]

{ #category : #elaboration }
PAtom >> elab__UeqUne: f [ 
	self shouldBeImplemented. "| r == Ueq || r == Une = do…"
]

{ #category : #'term rewriting' }
PAtom >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
	^(x evaluateIn: aBindEnv ifUndeclared: vndBlock)
		perform: brel
		with: (y evaluateIn: aBindEnv ifUndeclared: vndBlock)
]

{ #category : #comparing }
PAtom >> hash [
	^brel hash
]

{ #category : #'term rewriting' }
PAtom >> isTautoPred [
	^brel = Eq and: [ x = y ]
]

{ #category : #visiting }
PAtom >> mapExprOnExpr_case: f [
	^self shouldBeImplemented
]

{ #category : #printing }
PAtom >> printOn: aStream [
	aStream nextPut: $(.
	x printOn: aStream.
	aStream space.
	aStream nextPutAll: brel.
	aStream space.
	y printOn: aStream.
	aStream nextPut: $).
]

{ #category : #'SMT interface' }
PAtom >> smt2: γ [
	^(x smt2: γ) perform: brel with: (y smt2: γ)
]

{ #category : #'term rewriting' }
PAtom >> subst1: θ [ 
	^PAtom
		brel: brel
		x: (x subst1: θ)
		y: (y subst1: θ)
]

{ #category : #'term rewriting' }
PAtom >> subst: θ [ 
	^PAtom
		brel: brel
		x: (x subst: θ)
		y: (y subst: θ)
]

{ #category : #'term rewriting' }
PAtom >> substPred: oldToNewVarNameAssocs [
	^self shouldBeImplemented "?"
]

{ #category : #accessing }
PAtom >> x [
	^ x
]

{ #category : #accessing }
PAtom >> x: anObject [
	x := anObject
]

{ #category : #accessing }
PAtom >> y [
	^ y
]

{ #category : #accessing }
PAtom >> y: anObject [
	y := anObject
]
