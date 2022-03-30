Class {
	#name : #BMinus,
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BMinus class >> operator [
	^'-'
]

{ #category : #refinement }
BMinus class >> rTypeSrc [
	^'x:int => y:int => int[v|v===(x-y)]'
]
