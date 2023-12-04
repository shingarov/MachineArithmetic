Class {
	#name : #TvSub,
	#superclass : #SEnv,
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
TvSub >> subsTy: su [
"
instance SubsTy TvSub where
  subsTy = F.mapSEnv . subsTy
"
	^self collect: [ :t | t subsTy: su ]
]

{ #category : #'as yet unclassified' }
TvSub >> updSub: a rtype: t [
	^(t subsTy1: a x: self) copy at: a symbol put: t; yourself
]
