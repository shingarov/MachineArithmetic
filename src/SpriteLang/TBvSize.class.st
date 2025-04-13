Class {
	#name : #TBvSize,
	#superclass : #TCon,
	#instVars : [
		'ftycon'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
TBvSize >> ftycon [
	^ ftycon
]

{ #category : #accessing }
TBvSize >> ftycon: anObject [
	ftycon := anObject
]

{ #category : #printing }
TBvSize >> printOn: aStream [
	aStream nextPutAll: 'TBvSize('.
	ftycon printOn: aStream.
	aStream nextPutAll: ')'.
]

{ #category : #accessing }
TBvSize >> rTypeSort [
	^ ftycon fTyconSort
]

{ #category : #polymorphism }
TBvSize >> tsubstGo: t tVar: a [
	^self
]

{ #category : #polymorphism }
TBvSize >> unifyLL: tcon2 [
	| θ |
	θ := ([] as: Env) unify1: nil tvSubst: (TVSubst new) sort: self rTypeSort sort: tcon2 rTypeSort.
	self assert: θ isEmpty.
	^self
]

{ #category : #'synthesis constraints' }
TBvSize >> ≺ [ tcon2
	(tcon2 isKindOf: TCon) ifFalse: [ self error ].
	"self ftycon = tcon2 ftycon  ifFalse: [ self error ]."
	^CstrAnd of: {}
]
