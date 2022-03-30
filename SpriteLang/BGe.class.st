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
	^'x:int => y:int => bool[zzz|zzz <=> (x >= y)]'
]
