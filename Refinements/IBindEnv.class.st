Class {
	#name : #IBindEnv,
	#superclass : #Object,
	#instVars : [
		'indexes'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
IBindEnv class >> empty [
	^self from: #()
]

{ #category : #'as yet unclassified' }
IBindEnv class >> from: indexes [ 
	^self basicNew 
		indexes: indexes asSet;
		yourself 
]

{ #category : #'as yet unclassified' }
IBindEnv >> diff: e [
"
diffIBindEnv :: IBindEnv -> IBindEnv -> IBindEnv
"
	^IBindEnv from: (indexes difference: e indexes)
]

{ #category : #'as yet unclassified' }
IBindEnv >> elems [
	^indexes asArray 
]

{ #category : #'as yet unclassified' }
IBindEnv >> elemsIBindEnv [
"
elemsIBindEnv :: IBindEnv -> [BindId]
"
	^indexes asArray
]

{ #category : #'as yet unclassified' }
IBindEnv >> exElim: env xi: xi p: p [
"exElim :: F.SEnv (F.BindId, F.Sort) -> F.IBindEnv -> F.BindId -> F.Pred -> F.Pred"
	| yts |
	yts := p justVariables collectMaybe: [ :yVar |
		| y |
		y := yVar functorName.
		env at: y
			ifPresent: [ :yi_yt |
				| yi yt |
				yi := yi_yt key. yt := yi_yt value.
				(xi < yi and: [ indexes includes: yi  ])
					ifTrue: [ yVar ] ifFalse: [ nil ]
			] ifAbsent: [ nil ]].
	yts isEmpty ifTrue: [ ^p ].
	^p exists: yts asArray
]

{ #category : #environments }
IBindEnv >> filterIBindEnv: f [
"
filterIBindEnv :: (BindId -> Bool) -> IBindEnv -> IBindEnv
" 
	^self class from: (indexes select: f)
]

{ #category : #accessing }
IBindEnv >> indexes [
	^ indexes
]

{ #category : #accessing }
IBindEnv >> indexes: anObject [
	indexes := anObject
]

{ #category : #'as yet unclassified' }
IBindEnv >> insert: j [ 
	^self insertAll: { j. }
]

{ #category : #'as yet unclassified' }
IBindEnv >> insertAll: js [ 
	^IBindEnv from: self indexes, js
]

{ #category : #'set theory' }
IBindEnv >> intersection: anotherIBindEnv [ 
	^self class from: (self indexes intersection: anotherIBindEnv indexes)
]

{ #category : #testing }
IBindEnv >> isEmpty [
	^indexes isEmpty
]

{ #category : #printing }
IBindEnv >> printOn: aStream [
	aStream nextPutAll: 'IBindEnv'.
	self indexes printElementsOn: aStream 
]

{ #category : #'set theory' }
IBindEnv >> union: anotherIBindEnv [ 
	^self class from: (self indexes union: anotherIBindEnv indexes)
]
