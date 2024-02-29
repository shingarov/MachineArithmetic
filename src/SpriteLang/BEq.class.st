Class {
	#name : #BEq,
	#superclass : #'ΛInfixOp',
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
