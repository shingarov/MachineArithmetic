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
	^'x:''a => y:''a => bool[zzz|zzz <=> (x === y)]'
]
