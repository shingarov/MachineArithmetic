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
	^'ßx:''a => ßy:''a => bool[ßzzz|ßzzz <=> (ßx === ßy)]'
]
