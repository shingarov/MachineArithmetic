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

{ #category : #selfification }
PBitVector >> constTy [
	^TBase
		b: (TBitVector instance: length)
		r: (value///length) exprReft known
]

{ #category : #'term rewriting' }
PBitVector >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
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
