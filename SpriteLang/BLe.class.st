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
	^'x:''a => y:''a => bool[zzz|zzz <=> (x <= y)]'
]
