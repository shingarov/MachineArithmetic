Class {
	#name : #PUnknown,
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #selfification }
PUnknown >> constTy [
	^TAll
		var: 'a'
		type: (TVar symbol: 'a') bTrue
]
