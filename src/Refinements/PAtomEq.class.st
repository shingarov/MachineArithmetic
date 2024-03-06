Class {
	#name : #PAtomEq,
	#superclass : #Expr,
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
PAtomEq >> accept: aVisitor [
	^self class
		x: (x accept: aVisitor)
		y: (y accept: aVisitor)
]

{ #category : #'term rewriting' }
PAtomEq >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
	^(x evaluateIn: aBindEnv ifUndeclared: vndBlock)
	 ===
	 (y evaluateIn: aBindEnv ifUndeclared: vndBlock)
]

{ #category : #comparing }
PAtomEq >> hash [
	^x hash
]

{ #category : #'as yet unclassified' }
PAtomEq >> isTautoPred [
	^x=y
]

{ #category : #printing }
PAtomEq >> printOn: aStream [
	aStream nextPutAll: 'PAtomEq '.
	x printOn: aStream.
	aStream nextPutAll: '='.
	y printOn: aStream.
]

{ #category : #'term rewriting' }
PAtomEq >> subst1: θ [ 
	^PAtomEq
		x: (x subst1: θ)
		y: (y subst1: θ)
]

{ #category : #'term rewriting' }
PAtomEq >> subst: θ [ 
	^PAtomEq
		x: (x subst: θ)
		y: (y subst: θ)
]

{ #category : #'as yet unclassified' }
PAtomEq >> substPred: oldToNewVarNameAssocs [
	^self subclassResponsibility 
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
