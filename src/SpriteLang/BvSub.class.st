Class {
	#name : #BvSub,
	#superclass : #Dictionary,
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
BvSub >> subsTy: su [ 
	^self collect: [ :t | t subsTy: su ]
]

{ #category : #'as yet unclassified' }
BvSub >> updBvSub: a rtype: t [ 
	^(t subsBv1: a x: self) copy at: a symbol put: t; yourself
]
