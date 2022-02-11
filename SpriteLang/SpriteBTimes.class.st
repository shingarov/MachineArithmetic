Class {
	#name : #SpriteBTimes,
	#superclass : #SpritePrimOp,
	#category : #SpriteLang
}

{ #category : #syntax }
SpriteBTimes class >> operator [
	^'*'
]

{ #category : #refinement }
SpriteBTimes class >> rTypeSrc [
	^'x:int => y:int => int[v|v=x*y]'
]
