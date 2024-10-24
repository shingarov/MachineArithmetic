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
EBin >> smt2 [
	^left smt2 perform: bop with: right smt2
]
