Class {
	#name : #PatNone,
	#superclass : #QualPattern,
	#category : #Refinements
}

{ #category : #matching }
PatNone >> matchSym: y′ [
"
matchSym :: F.QualPattern -> F.Symbol -> Maybe QPSubst
"
	^NoSub new
]

{ #category : #printing }
PatNone >> printOn: aStream [
	aStream nextPutAll: 'PatNone'
]
