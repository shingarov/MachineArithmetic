Class {
	#name : #Refl,
	#superclass : #SpriteAnn,
	#category : #SpriteLang
}

{ #category : #reflect }
Refl class >> reflect: equationName type: t expr: e [
	^t reflect: equationName expr: e
]

{ #category : #printing }
Refl >> spriteOn: stream indent: level [
	stream nextPutAll: '⟦reflect '.
	stream nextPutAll: symbol.
	stream nextPutAll: ' : '.
	rtype spriteOn: stream indent: level.
	stream nextPutAll: '⟧'.
]
