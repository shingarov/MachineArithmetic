Class {
	#name : #SpriteBMinus,
	#superclass : #SpritePrimOp,
	#category : #SpriteLang
}

{ #category : #syntax }
SpriteBMinus class >> operator [
	^'-'
]

{ #category : #refinement }
SpriteBMinus class >> rTypeSrc [
	^'x:int => y:int => int[v|v=x-y]'
]
