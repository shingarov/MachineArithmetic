Class {
	#name : #BLe,
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BLe class >> operator [
	^'<='
]

{ #category : #selfification }
BLe class >> rTypeSrc [
	^'ßx:''a => ßy:''a => bool[ßzzz|ßzzz <=> (ßx <= ßy)]'
]
