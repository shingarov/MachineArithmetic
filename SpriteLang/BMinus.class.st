Class {
	#name : #BMinus,
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BMinus class >> operator [
	^'-'
]

{ #category : #selfification }
BMinus class >> rTypeSrc [
	^'ßx:int => ßy:int => int[ßv|ßv===(ßx-ßy)]'
]
