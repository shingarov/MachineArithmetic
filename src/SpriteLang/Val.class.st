Class {
	#name : #Val,
	#superclass : #SpriteAnn,
	#category : #SpriteLang
}

{ #category : #reflect }
Val class >> reflect: equationName type: t expr: e [
	^t
]

{ #category : #'as yet unclassified' }
Val >> spriteOn: stream indent: level [
	stream nextPutAll: '⟦val '.
	stream nextPutAll: symbol.
	stream nextPutAll: ' : '.
	rtype spriteOn: stream indent: level.
	stream nextPutAll: '⟧'.
]
