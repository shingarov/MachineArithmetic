Class {
	#name : #BGe,
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BGe class >> operator [
	^'>='
]

{ #category : #selfification }
BGe class >> rTypeSrc [
	^'ßx:''a => ßy:''a => bool[ßzzz|ßzzz <=> (ßx >= ßy)]'
]
