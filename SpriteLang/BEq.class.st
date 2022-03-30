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
	^'x:int => y:int => bool[zzz|zzz <=> (x === y)]'
]
