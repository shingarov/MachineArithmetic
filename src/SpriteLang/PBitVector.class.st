Class {
	#name : #PBitVector,
	#superclass : #'ΛPrim',
	#instVars : [
		'length',
		'value'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
PBitVector class >> length: length value: value [
	^self basicNew
		length: length;
		value: value;
		yourself.
]

{ #category : #'as yet unclassified' }
PBitVector >> constTy [
	| freshVar exprReft |
	freshVar := '_VV'.
	exprReft := Reft
		symbol: freshVar
		expr: (DecidableRefinement text: freshVar, ' === (', value printString ,' toBitVector: ', length printString ,' )').
	^TBase b: (TBitVector instance: length) r: exprReft known
]

{ #category : #'term rewriting' }
PBitVector >> evaluateIn: aBindEnv [
	^value toBitVector: length
]

{ #category : #'as yet unclassified' }
PBitVector >> immExprX [
	^self
]

{ #category : #accessing }
PBitVector >> length [
	^ length
]

{ #category : #initialization }
PBitVector >> length: anObject [
	length := anObject
]

{ #category : #accessing }
PBitVector >> value [
	^ value
]

{ #category : #initialization }
PBitVector >> value: anObject [
	value := anObject
]
