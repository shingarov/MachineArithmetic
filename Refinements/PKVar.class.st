Class {
	#name : #PKVar,
	#superclass : #Object,
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

{ #category : #'as yet unclassified' }
PKVar >> conjuncts [
	^{self}
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

{ #category : #'as yet unclassified' }
PKVar >> refaConjuncts [
	^self conjuncts reject: #isTautoPred
]

{ #category : #accessing }
PKVar >> s [
	^ s
]

{ #category : #accessing }
PKVar >> s: anObject [
	s := anObject
]

{ #category : #'term rewriting' }
PKVar >> subst1: newExpr for: oldName [
	"cf. Substitutions.hs:163"
	^self subst: (Subst mkSubst: {oldName->newExpr})
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
