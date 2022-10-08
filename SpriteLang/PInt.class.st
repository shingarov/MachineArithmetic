Class {
	#name : #PInt,
	#superclass : #'ΛPrim',
	#instVars : [
		'integer'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
PInt class >> integer: integer [
	^self basicNew integer: integer; yourself 
]

{ #category : #'as yet unclassified' }
PInt >> constTy [
"
constTy _ (PInt n) = TBase TInt (F.exprReft (F.expr n))
"
	| freshVar exprReft |
	freshVar := '_VV'.
	exprReft := Reft
		symbol: freshVar
		expr: (DecidableRefinement text: freshVar, ' === ', integer printString).
	^TBase b: TInt instance r: exprReft known
]

{ #category : #'as yet unclassified' }
PInt >> evaluateIn: aBindEnv [ 
	^integer toInt
]

{ #category : #'as yet unclassified' }
PInt >> immExprX [
	^self
]

{ #category : #accessing }
PInt >> integer [
	^ integer
]

{ #category : #accessing }
PInt >> integer: anObject [
	integer := anObject
]
