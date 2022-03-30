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
	^'x:int => y:int => bool[zzz|zzz <=> (x < y)]'
]
