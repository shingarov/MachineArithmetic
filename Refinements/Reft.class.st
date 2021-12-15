"
Parsed refinement of @Symbol@ as @Expr@
e.g. in '{v: _ | e }' v is the @Symbol@ and e the @Expr@
"
Class {
	#name : #Reft,
	#superclass : #Object,
	#instVars : [
		'symbol',
		'expr'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Reft class >> alwaysTrue [
	^self symbol: nil expr: (HPredAnd of: #())
]

{ #category : #'instance creation' }
Reft class >> expr: p [
	^self symbol: nil expr: p
]

{ #category : #'instance creation' }
Reft class >> symbol: s expr: p [
	^self basicNew 
		symbol: s;
		expr: p;
		yourself
]

{ #category : #accessing }
Reft >> expr [
	^ expr
]

{ #category : #accessing }
Reft >> expr: anObject [
	expr := anObject
]

{ #category : #'as yet unclassified' }
Reft >> mapKVarSubsts: aBlock [ 
	expr := expr mapKVarSubsts: aBlock 
]

{ #category : #'as yet unclassified' }
Reft >> shiftR: i [ 
	^self shiftVV: (self symbol intSymbol: i)
]

{ #category : #'as yet unclassified' }
Reft >> shiftVV: newSymbol [
	"Replace symbol with newSymbol everywhere."
	| newExpr |
	symbol = newSymbol ifTrue: [ ^self ].
	newExpr := self expr subst1: (EVar of: newSymbol) for: symbol.
	^Reft symbol: newSymbol expr: newExpr
]

{ #category : #accessing }
Reft >> symbol [
	^ symbol
]

{ #category : #accessing }
Reft >> symbol: anObject [
	symbol := anObject
]
