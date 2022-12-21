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
	^'x:''a => y:''a => bool[zzz|zzz <=> (x >= y)]'
]
