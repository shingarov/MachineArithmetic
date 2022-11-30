Class {
	#name : #BLt,
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BLt class >> operator [
	^'<'
]

{ #category : #selfification }
BLt class >> rTypeSrc [
	^'ßx:''a => ßy:''a => bool[ßzzz|ßzzz <=> (ßx < ßy)]'
]
