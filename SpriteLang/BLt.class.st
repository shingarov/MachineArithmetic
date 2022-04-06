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
	^'ßx:int => ßy:int => bool[ßzzz|ßzzz <=> (ßx < ßy)]'
]
