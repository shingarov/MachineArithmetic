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
	^'ßx:int => ßy:int => bool[ßzzz|ßzzz <=> (ßx <= ßy)]'
]
