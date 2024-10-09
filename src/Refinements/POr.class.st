Class {
	#name : #POr,
	#superclass : #Expr,
	#instVars : [
		'disjuncts'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
POr class >> of: disjuncts [
	^self basicNew
		disjuncts: disjuncts;
		yourself
]

{ #category : #visiting }
POr >> accept: aVisitor [
	^self class of: (disjuncts collect: [ :each | each accept: aVisitor ])
]

{ #category : #accessing }
POr >> disjuncts [
	^ disjuncts
]

{ #category : #accessing }
POr >> disjuncts: anObject [
	disjuncts := anObject
]

{ #category : #elaboration }
POr >> elab: γ [
	^{
		POr of: (disjuncts collect: [ :each | (each elab: γ) first ]).
		Bool sort
	}
]

{ #category : #'term rewriting' }
POr >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
	| conjunctValues |
	conjunctValues := disjuncts collect: [ :each | each evaluateIn: aBindEnv ifUndeclared: vndBlock ].
	^self class of: conjunctValues
]

{ #category : #'SMT interface' }
POr >> smt2 [
	(disjuncts allSatisfy: #isConc) ifFalse: [ self shouldBeImplemented ].
	^Bool or: (disjuncts collect: #smt2)
]

{ #category : #'F.Subable' }
POr >> subst: su [ 
	^self class of: (disjuncts collect: [ :each | each subst: su ])
]
