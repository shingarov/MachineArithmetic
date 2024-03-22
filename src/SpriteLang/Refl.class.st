Class {
	#name : #Refl,
	#superclass : #SpriteAnn,
	#category : #SpriteLang
}

{ #category : #reflect }
Refl class >> reflect: equationName type: t expr: e [
	^t reflect: equationName expr: e
]
