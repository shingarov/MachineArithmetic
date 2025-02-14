Class {
	#name : #Env,
	#superclass : #BlockClosure,
	#type : #variable,
	#category : #Refinements
}

{ #category : #elaboration }
Env >> checkSym: x [
"
checkSym :: Env -> Symbol -> CheckM Sort
"
	^x⋅self
		ifFound: #instantiate
		alts: #error
]

{ #category : #unification }
Env >> unify1: e tvSubst: θ sort: t₁ sort: t₂ [
"
unify1 :: Env -> Maybe Expr -> TVSubst -> Sort -> Sort -> CheckM TVSubst
           f            e        θ         t1      t2
Cf. SortCheck.hs
"
	| t1 t2 |
	t1 := t₁ guest.
	t2 := t₂ guest.
	(t1 isKindOf: FVar) ifTrue: [ ^t2 unifyVar: self maybeExpr: e tvSubst: θ int: t1 i ].
	(t2 isKindOf: FVar) ifTrue: [ ^t1 unifyVar: self maybeExpr: e tvSubst: θ int: t2 i ].
	(t1 isKindOf: FApp) ifTrue: [
		(t2 isKindOf: FApp) ifTrue: [ ^self unifyMany: e tvSubst: θ sorts: { t1 s . t1 t } sorts: { t2 s . t2 t } ].
		(t2 isKindOf: Z3IntSort) ifTrue: [ ^nil ].
		(t2 isKindOf: Z3BoolSort) ifTrue: [ ^nil ].
		(t2 isKindOf: Z3UninterpretedSort) ifTrue: [ ^nil ].
		^self unify1: e tvSubst: θ sort: t1 sort: t2 guest
	].
	((t1 isKindOf: FTC) and: [t2 isKindOf: FTC]) ifTrue: [
		(t1 typeConstructor isListTC and: [ t2 typeConstructor isListTC ]) ifTrue: [ ^θ ] ].
	(t1 isKindOf: FAbs) ifTrue: [ self shouldBeImplemented ].
	(t2 isKindOf: FAbs) ifTrue: [ self shouldBeImplemented ].
	"TODO: insert ℝ ≅ ℤ here"
	"ℤ on either side:"
	(t1 isKindOf: Z3IntSort) ifTrue: [ ^t2 checkNumeric: self tvSubst: θ ].
	(t2 isKindOf: Z3IntSort) ifTrue: [ ^t1 checkNumeric: self tvSubst: θ ].

	((t1 isKindOf: FFunc) and: [t2 isKindOf: FFunc]) ifTrue: [ self shouldBeImplemented ].
	(t1 isKindOf: Z3UninterpretedSort) ifTrue: [ |a| a := t1 name getString. ^t2 checkEqConstr: self maybeExpr: e tvSubst: θ symbol: a ].
	(t2 isKindOf: Z3UninterpretedSort) ifTrue: [ |a| a := t2 name getString. ^t1 checkEqConstr: self maybeExpr: e tvSubst: θ symbol: a ].
	
	t1 = t2 ifTrue: [ ^θ ].
	Incompatible signal
]

{ #category : #unification }
Env >> unify: e sort: t1 sort: t2 [
	[^self unify1: e tvSubst: (Context readState: #tvSubst) sort: t1 sort: t2 ] runReader: #tvSubst initialState: TVSubst new
]

{ #category : #unification }
Env >> unifyMany: e tvSubst: θ sorts: ts sorts: ts′ [
"
unifyMany :: HasCallStack => Env -> Maybe Expr -> TVSubst -> [Sort] -> [Sort] -> CheckM TVSubst
"
	| zip |
	ts size = ts′ size ifFalse: [ self error ].
	zip := ts zip: ts′.
	zip collectAssociations: [ :t :t_ | self unify1: e tvSubst: θ sort: t sort: t_ ].
	"we destructively modify θ in place"
	^θ
]
