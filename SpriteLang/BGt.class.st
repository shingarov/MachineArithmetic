Class {
	#name : #BGt,
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BGt class >> operator [
	^'>'
]

{ #category : #selfification }
BGt class >> rTypeSrc [
	^'x:int => y:int => bool[zzz|zzz <=> (x > y)]'
]
