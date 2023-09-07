Class {
	#name : #BNe,
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BNe class >> operator [
	^'!='
]

{ #category : #selfification }
BNe class >> rTypeSrc [
	^'x:''a => y:''a => bool[zzz|zzz <=> (x === y) not]'
]
