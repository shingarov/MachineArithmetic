"
data Expr =
          ...
          | EBin !Bop !Expr !Expr

data Bop  = Plus | Minus | Times | Div | Mod | RTimes | RDiv
            deriving (Eq, Ord, Show, Data, Typeable, Generic)
            -- NOTE: For ""Mod"" 2nd expr should be a constant or a var *)
"
Class {
	#name : #EBin,
	#superclass : #Expr,
	#instVars : [
		'bop',
		'left',
		'right'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EBin class >> bop: bop left: left right: right [
	^self basicNew
		bop: bop;
		left: left;
		right: right;
		yourself
]

{ #category : #'instance creation' }
EBin class >> normalizeBopSelector: s [
	^(Bop classPool includes: s)
		ifTrue: [ s ]
		ifFalse: [ nil ]
]

{ #category : #visiting }
EBin >> accept: aVisitor [
	^self class
		bop: bop
		left: (left accept: aVisitor)
		right: (right accept: aVisitor)
]

{ #category : #accessing }
EBin >> bop [
	^ bop
]

{ #category : #accessing }
EBin >> bop: anObject [
	bop := anObject
]

{ #category : #'sort-checking' }
EBin >> checkExpr: f [ 
	^f checkOp: bop e₁: left e₂: right
]

{ #category : #elaboration }
EBin >> checkOpTy_in: anEnv t₁: leftSort t₂: rightSort [
"
checkOpTy :: Env -> Expr -> Sort -> Sort -> CheckM Sort
"
	| s |
	(leftSort = Int sort) & (rightSort = Int sort) ifTrue: [ ^Int sort ].
	s := anEnv unify: self sort: leftSort sort: rightSort.
	s isNil ifFalse: [ 
		"
		| Just s <- unify f (Just e) t t'
		= checkNumeric f (apply s t) >> return (apply s t)
		"
		s isEmpty ifFalse: [ self shouldBeImplemented "checkNumeric f (apply s t) >> return (apply s t)" ].
		^leftSort
	].
	self error
]

{ #category : #elaboration }
EBin >> elab: f [
"
elab f@(_, g) e@(EBin o e1 e2)
"
	| e₁′_s₁ e₁′ s₁ e₂′_s₂ e₂′ s₂ s |
	e₁′_s₁ := left  elab: f.  e₁′ := e₁′_s₁ first. s₁ := e₁′_s₁ second.
	e₂′_s₂ := right elab: f.  e₂′ := e₂′_s₂ first. s₂ := e₂′_s₂ second.
	
	s := self checkOpTy_in: f env t₁: s₁ t₂: s₂.
	^{
		EBin
			bop: bop
			left:  (ECst expr: e₁′ sort: s₁)
			right: (ECst expr: e₂′ sort: s₂).
		s
	}
]

{ #category : #elaboration }
EBin >> elabApplyStep: γ [ 
	^EBin
		bop: bop
		left:  (left elabApply: γ)
		right: (right elabApply: γ)
]

{ #category : #'term rewriting' }
EBin >> evaluateIn: anEvalEnv ifUndeclared: vndBlock [
	^(left evaluateIn: anEvalEnv ifUndeclared: vndBlock)
		perform: bop
		with: (right evaluateIn: anEvalEnv ifUndeclared: vndBlock)
]

{ #category : #accessing }
EBin >> left [
	^ left
]

{ #category : #accessing }
EBin >> left: anObject [
	left := anObject
]

{ #category : #accessing }
EBin >> right [
	^ right
]

{ #category : #accessing }
EBin >> right: anObject [
	right := anObject
]

{ #category : #'SMT interface' }
EBin >> smt2: γ [
	^(left smt2: γ) perform: bop with: (right smt2: γ)
]
