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
	^'ßx:int => ßy:int => int[ßv|ßv===(ßx+ßy)]'
]
