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
	^self expr: (HPredAnd of: #())
]

{ #category : #'instance creation' }
Reft class >> anonymousVarName [
	^'VV'
]

{ #category : #'instance creation' }
Reft class >> expr: p [
	^self symbol: self anonymousVarName expr: p
]

{ #category : #'instance creation' }
Reft class >> symbol: s expr: p [
	^self basicNew 
		symbol: s;
		expr: p;
		yourself
]

{ #category : #'as yet unclassified' }
Reft >> conjuncts [
"reftConjuncts :: Reft -> [Reft]
cf. Refinements.hs"
	| v ra ks ps ras1 |
	v := symbol.
	ra := expr.
	ks := ra refaConjuncts select: [ :p | p isKVar "or: [ p isGradual ] BOGUS" ].
	ps := ra refaConjuncts reject: [ :p | p isKVar "or: [ p isGradual ] BOGUS" ].
	ras1 := ps isEmpty 
		ifTrue: [ ks ]
		ifFalse: [ ps size = 1 ifFalse: [self shouldBeImplemented].  ps, ks ].
	^ras1 collect: [ :ra1 | Reft symbol: v expr: ra1 ]
]

{ #category : #compilation }
Reft >> evaluateIn: aBindEnv [ 
	^Reft
		symbol: symbol
		expr: (expr evaluateIn: aBindEnv)
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

{ #category : #printing }
Reft >> printBracketedOn: aStream [
	aStream
			nextPutAll: '[';
			nextPutAll: (self symbol isNil ifTrue: ['_'] ifFalse: [symbol]);
			nextPutAll: '|'.
	expr printOn: aStream.
	aStream nextPutAll: ']'.
]

{ #category : #printing }
Reft >> printOn: aStream [
	aStream nextPutAll: 'Reft'.
	self printBracketedOn: aStream
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
	newExpr := self expr subst1: (FxEVar of: newSymbol) for: symbol.
	^Reft symbol: newSymbol expr: newExpr
]

{ #category : #'as yet unclassified' }
Reft >> subst1: toExpr for: fromVar [ 
	fromVar = symbol ifTrue: [ self error ].
	^Reft
		symbol: symbol
		expr: (expr subst1: toExpr for: fromVar)
]

{ #category : #accessing }
Reft >> symbol [
	^ symbol
]

{ #category : #accessing }
Reft >> symbol: anObject [
	symbol := anObject
]
