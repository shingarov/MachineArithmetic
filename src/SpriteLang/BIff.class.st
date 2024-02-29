Class {
	#name : #BIff,
	#superclass : #'ΛInfixOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BIff class >> operator [
	^'<=>'
]

{ #category : #selfification }
BIff class >> rTypeSrc [
	^'x:''a => y:''a => bool[zzz|zzz <=> (x <=> y)]'
]
