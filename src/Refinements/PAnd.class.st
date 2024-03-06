"
data Expr =
          ...
          | PAnd  ![Expr]

Caveat programmator: this is NOT the same as PAnd in Horn/Types (HPredAnd).
"
Class {
	#name : #PAnd,
	#superclass : #Expr,
	#instVars : [
		'conjuncts'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
PAnd class >> of: conjuncts [
	^self basicNew
		conjuncts: conjuncts;
		yourself
]

{ #category : #comparing }
PAnd >> = another [
	self class = another class ifFalse: [ ^false ].
	^conjuncts = another conjuncts
]

{ #category : #visiting }
PAnd >> accept: aVisitor [
	^self class of: (conjuncts collect: [ :each | each accept: aVisitor ])
]

{ #category : #GT }
PAnd >> children [
	^conjuncts
]

{ #category : #accessing }
PAnd >> conjuncts [
	^conjuncts collectAndCat: #conjuncts
]

{ #category : #accessing }
PAnd >> conjuncts: aCollection [ 
	conjuncts := aCollection
]

{ #category : #elaboration }
PAnd >> elab: γ [
	^{
		PAnd of: (conjuncts collect: [ :each | (each elab: γ) first ]).
		Bool sort
	}
]

{ #category : #'as yet unclassified' }
PAnd >> elabApplyStep: γ [ 
	^PAnd of: (conjuncts collect: [ :each | each elabApply: γ ])
]

{ #category : #'term rewriting' }
PAnd >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
	| conjunctValues |
	conjunctValues := conjuncts collect: [ :each | each evaluateIn: aBindEnv ifUndeclared: vndBlock ].
	^PAnd of: conjunctValues

]

{ #category : #logic }
PAnd >> flatten [
"
instance Flatten F.Expr where
  flatten (F.PAnd ps) = case flatten ps of
                         [p] -> p
                         ps  -> F.PAnd ps
"
	| flatConjuncts |
	flatConjuncts := self conjuncts flatten.
	"special-case of singleton collection"
	flatConjuncts size = 1 ifTrue: [ ^flatConjuncts anyOne ].
	^PAnd of: flatConjuncts
]

{ #category : #comparing }
PAnd >> hash [
	^conjuncts size hash
]

{ #category : #'as yet unclassified' }
PAnd >> isTautoPred [
	^conjuncts isEmpty
]

{ #category : #'term rewriting' }
PAnd >> kvarsExpr [
	^((conjuncts collect: #kvarsExpr) collectAndCat: #asArray) asSet asArray
]

{ #category : #printing }
PAnd >> printOn: aStream [
	aStream nextPut: $&.
	self conjuncts printElementsOn: aStream 
]

{ #category : #'α-renaming' }
PAnd >> rename: a to: b [
	^self class of: (conjuncts collect: [ :each | each rename: a to: b ])
]

{ #category : #'SMT interface' }
PAnd >> smt2: γ [
	| cs |
	cs := conjuncts collect: [ :each | each smt2: γ ].
	^(cs allSatisfy: #isConc)
		ifTrue: [ Bool and: cs ]
		ifFalse: [ ^self class of: cs ]
]

{ #category : #'SMT interface' }
PAnd >> sort [
	^Bool sort
]

{ #category : #'F.Subable' }
PAnd >> subst1: ass [
	^PAnd of: (conjuncts collect: [ :each | each subst1: ass ])
]

{ #category : #'F.Subable' }
PAnd >> subst: su [
	^self class of: (conjuncts collect: [ :each | each subst: su ])
]

{ #category : #'F.Subable' }
PAnd >> substf: f [ 
	^self class of: (conjuncts collect: [ :each | each substf: f ])
]
