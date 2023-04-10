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
SimpC >> compileIn: aBindEnv [ 
	rhs := rhs evaluateIn: aBindEnv evalEnv 
]

{ #category : #logic }
SimpC >> crhs [
	^rhs
]

{ #category : #'as yet unclassified' }
SimpC >> elaborate: γ [
"
instance (Loc a) => Elaborate (SimpC a) where
  elaborate msg env c = c {_crhs = elaborate msg' env (_crhs c) }
    where msg'        = atLoc c (val msg)
"
	^self copy
		rhs: (rhs elaborate: γ);
		yourself
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

{ #category : #'SMT interface' }
SimpC >> smt2: aSymEnv [
	"Destructively replace RHS with its Z3 AST."
	rhs := rhs smt2: aSymEnv.
	^self
	
]

{ #category : #GT }
SimpC >> textForGT_subclassSpecific [
	^'bindId: ', bindId printString, String cr
]

{ #category : #GT }
SimpC >> textTabLabel [
	^'Simple constraint'
]
