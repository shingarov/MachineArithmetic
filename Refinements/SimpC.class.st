Class {
	#name : #SimpC,
	#superclass : #AbstractC,
	#instVars : [
		'bindId'
	],
	#category : #Refinements
}

{ #category : #visiting }
SimpC >> accept: aVisitor [
	^self copy
		rhs: (rhs accept: aVisitor);
		yourself
]

{ #category : #logic }
SimpC >> clhs: be [
	"cf. 'instance TaggedC SimpC a' in Constraints.hs"
	^be envCs: self senv
]

{ #category : #'as yet unclassified' }
SimpC >> compileIn: anEvalEnv [ 
	rhs := rhs evaluateIn: anEvalEnv
]

{ #category : #logic }
SimpC >> crhs [
	^rhs
]

{ #category : #'as yet unclassified' }
SimpC >> elabApply: γ [
	^self copy
		rhs: (rhs elabApply: γ);
		yourself
]

{ #category : #Elaborate }
SimpC >> elaborate: γ [
"
instance (Loc a) => Elaborate (SimpC a) where
  elaborate msg env c = c {_crhs = elaborate msg' env (_crhs c) }
    where msg'        = atLoc c (val msg)
In Smalltalk we do this destructively.
"
	rhs := rhs elaborate: γ
]

{ #category : #'as yet unclassified' }
SimpC >> initializeFrom: subc bindm: m [
	env := subc env.
	rhs := subc rhs sr_reft expr.
	id := subc id.
	bindId := m at: subc id


]

{ #category : #'as yet unclassified' }
SimpC >> isChecked [
	"checkCstr cfg; cf. Solve.hs"
	^true
]

{ #category : #'as yet unclassified' }
SimpC >> lookupBindIn: aBindEnv [ 
	^(aBindEnv lookup: bindId) key
]

{ #category : #'as yet unclassified' }
SimpC >> nonCutCube [
"
nonCutCube :: SimpC a -> Sol.Cube
"
	^Cube
		binds: self senv
		subst: self rhsSubst
		id: id
]

{ #category : #'as yet unclassified' }
SimpC >> rhsSubst [
"
rhsSubst :: SimpC a -> Subst
"
	^self crhs "can only return a PKVar"
		s
]

{ #category : #'as yet unclassified' }
SimpC >> senv [
	^env
]

{ #category : #'as yet unclassified' }
SimpC >> sinfo [
	^info
]

{ #category : #'SMT interface' }
SimpC >> smt2: aSymEnv [
	"Destructively replace RHS with its Z3 AST."
	rhs := rhs smt2: aSymEnv.
	^self
	
]

{ #category : #'as yet unclassified' }
SimpC >> subcId [
	^id
]

{ #category : #sanitizing }
SimpC >> subcKSubs: xsrs [
"
subcKSubs :: Fixpoint a => [(F.Symbol, F.SortedReft)] -> F.SimpC a -> [KSub]
type KSub = (Maybe F.Symbol, F.KVar, F.Subst)
"
	| l r |
	l := xsrs asArray collectAndCat: [ :xsr |
		| sr rs |
		sr := xsr value.
		rs := sr sr_reft pkvarConjuncts.
		rs := rs select: [ :eachR | eachR expr isKindOf: PKVar ].
		rs collect: [ :each | { each symbol . each expr var . each expr s } ] ].
	r := (self crhs isKindOf: PKVar)
		ifTrue: [ {{ nil . self crhs var . self crhs s }} ]
		ifFalse: [ #() ].
	^l, r
]

{ #category : #GT }
SimpC >> textForGT_subclassSpecific [
	^'bindId: ', bindId printString, String cr
]

{ #category : #GT }
SimpC >> textTabLabel [
	^'Simple constraint'
]
