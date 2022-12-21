Class {
	#name : #BPlus,
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BPlus class >> operator [
	^'+'
]

{ #category : #refinement }
BPlus class >> rTypeSrc [
	^'x:int => y:int => int[v|v===(x+y)]'
]
