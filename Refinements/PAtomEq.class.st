Class {
	#name : #PAtomEq,
	#superclass : #HPred,
	#instVars : [
		'x',
		'y'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
PAtomEq class >> x: x y: y [ 
	^self basicNew 
		x: x;
		y: y;
		yourself
]

{ #category : #comparing }
PAtomEq >> = another [
	self class = another class ifFalse: [ ^false ].
	^x = another x and: [ y = another y ]
]

{ #category : #'term rewriting' }
PAtomEq >> evaluateIn: aBindEnv [ 
	^(aBindEnv evaluate: x) === (aBindEnv evaluate: y)
]

{ #category : #comparing }
PAtomEq >> hash [
	^x hash
]

{ #category : #printing }
PAtomEq >> printOn: aStream [
	aStream nextPutAll: 'PAtomEq '.
	x printOn: aStream.
	aStream nextPutAll: '='.
	y printOn: aStream.
]

{ #category : #'term rewriting' }
PAtomEq >> subst: θ [ 
	^PAtomEq
		x: (x subst: θ)
		y: (y subst: θ)
]

{ #category : #accessing }
PAtomEq >> x [
	^ x
]

{ #category : #accessing }
PAtomEq >> x: anObject [
	x := anObject
]

{ #category : #accessing }
PAtomEq >> y [
	^ y
]

{ #category : #accessing }
PAtomEq >> y: anObject [
	y := anObject
]
