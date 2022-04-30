Class {
	#name : #TvSub,
	#superclass : #Dictionary,
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
TvSub >> subsTy: su [ 
	^self collect: [ :t | t subsTy: su ]
]

{ #category : #'as yet unclassified' }
TvSub >> updSub: a rtype: t [
	^(t subsTy1: a x: self) copy at: a symbol put: t; yourself
]
