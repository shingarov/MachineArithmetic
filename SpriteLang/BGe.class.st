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
	^'ßx:int => ßy:int => bool[ßzzz|ßzzz <=> (ßx >= ßy)]'
]
