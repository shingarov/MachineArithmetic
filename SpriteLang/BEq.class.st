Class {
	#name : #BEq,
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BEq class >> operator [
	^'=='
]

{ #category : #selfification }
BEq class >> rTypeSrc [
	^'ßx:int => ßy:int => bool[ßzzz|ßzzz <=> (ßx === ßy)]'
]
