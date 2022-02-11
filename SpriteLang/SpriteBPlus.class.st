Class {
	#name : #SpriteBPlus,
	#superclass : #SpritePrimOp,
	#category : #SpriteLang
}

{ #category : #syntax }
SpriteBPlus class >> operator [
	^'+'
]

{ #category : #refinement }
SpriteBPlus class >> rTypeSrc [
	^'x:int => y:int => int[v|v=x+y]'
]
