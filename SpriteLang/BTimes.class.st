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
	^'ßx:int => ßy:int => int[ßv|ßv===(ßx*ßy)]'
]
