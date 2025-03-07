Class {
	#name : #PInt,
	#superclass : #'ΛPrim',
	#instVars : [
		'integer'
	],
	#pools : [
		'Brel'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
PInt class >> integer: integer [
	^self basicNew integer: integer; yourself 
]

{ #category : #'primitive types' }
PInt >> constTy [
"
constTy _ (PInt  n)     = TBase TInt  (known $ F.exprReft (F.expr n))
"
	^TBase
		b: TInt instance
		r: integer expr exprReft known
]

{ #category : #'as yet unclassified' }
PInt >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
	^integer toInt
]

{ #category : #GT }
PInt >> gtChildren [
	^{}
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
