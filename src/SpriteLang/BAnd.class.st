Class {
	#name : #BAnd,
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BAnd class >> operator [
	^'&&'
]

{ #category : #selfification }
BAnd class >> rTypeSrc [
	^'x:bool => y:bool => bool[v|v <=> (x & y)]'
]
