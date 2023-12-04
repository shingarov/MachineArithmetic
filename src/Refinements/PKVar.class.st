Class {
	#name : #PKVar,
	#superclass : #Expr,
	#instVars : [
		'var',
		's'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
PKVar class >> var: v subst: s [
	^self basicNew
		var: v;
		s: s;
		yourself
]

{ #category : #visiting }
PKVar >> accept: aVisitor [
	| e1 |
	e1 := aVisitor txExpr value: self.
	"TODO: implement accum"
	^e1
]

{ #category : #elaboration }
PKVar >> elab: anElabEnv [
	^self elabArgsIn: anElabEnv senv sort
]

{ #category : #'as yet unclassified' }
PKVar >> elabApplyStep: _ [ 
	^self
]

{ #category : #elaboration }
PKVar >> elabArgsIn: sEnv [
	s associationsDo: [ :k_v |
			| kSort argVarName vSort |
			kSort := sEnv at: k_v key.
			argVarName := k_v value sym.
			vSort := sEnv at: argVarName
				ifAbsentPut: [
					"[argVarName] is a yet-unknown free variable;
					 there is nothing to verify, so we just insert its sort
					 (which is the argument sort from the declaration of κ)
					 into sEnv.
					 The rest of of this method (the unify) then becomes a nop."
					kSort
				].
			(Z3Sort
				unify1: nil
				maybeExpr: nil
				tvSubst: TVSubst new
				sort: kSort
				sort: vSort) isEmpty ifFalse: [ self error ] ].
	^{self . Bool sort}
]

{ #category : #'as yet unclassified' }
PKVar >> evaluateIn: aBindEnv [
	^PKVar
		var: var
		subst: (s evaluateIn: aBindEnv)
]

{ #category : #'as yet unclassified' }
PKVar >> isConc [
	"This should be pulled up."
	^self kvarsExpr isEmpty
]

{ #category : #'as yet unclassified' }
PKVar >> isKVar [
	^true
]

{ #category : #'as yet unclassified' }
PKVar >> isSingletonExpr: v in: env [ 
	^nil
]

{ #category : #'as yet unclassified' }
PKVar >> isTautoPred [
	^false "BOGUS??"
]

{ #category : #'as yet unclassified' }
PKVar >> kvarsExpr [
	^Set with: var
]

{ #category : #'as yet unclassified' }
PKVar >> predKs [
"cf. Solve.hs"
	^{var->s}
]

{ #category : #printing }
PKVar >> printOn: aStream [ 
	aStream nextPut: $$.
	aStream nextPutAll: var.
	s printOn: aStream
]

{ #category : #accessing }
PKVar >> s [
	^ s
]

{ #category : #accessing }
PKVar >> s: anObject [
	s := anObject
]

{ #category : #'SMT interface' }
PKVar >> smt2: _ [ 
	^self
]

{ #category : #'term rewriting' }
PKVar >> subst: su [
	| su1 |
	su1 := s.
	^PKVar
		var: var
		subst: (su1 cat: su)
]

{ #category : #accessing }
PKVar >> var [
	^ var
]

{ #category : #accessing }
PKVar >> var: anObject [
	var := anObject
]
