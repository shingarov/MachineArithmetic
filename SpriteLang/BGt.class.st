Class {
	#name : #BGt,
	#superclass : #'ΛPrimOp',
	#category : #SpriteLang
}

{ #category : #syntax }
BGt class >> operator [
	^'>'
]

{ #category : #selfification }
BGt class >> rTypeSrc [
	^'ßx:''a => ßy:''a => bool[ßzzz|ßzzz <=> (ßx > ßy)]'
]
