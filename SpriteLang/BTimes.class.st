Class {
	#name : #BTimes,
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BTimes class >> operator [
	^'*'
]

{ #category : #refinement }
BTimes class >> rTypeSrc [
	^'x:int => y:int => int[v|v===(x*y)]'
]
