Class {
	#name : #BImply,
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BImply class >> operator [
	^'==>'
]

{ #category : #selfification }
BImply class >> rTypeSrc [
	^'x:''a => y:''a => bool[zzz|zzz <=> (x ==> y)]'
]
