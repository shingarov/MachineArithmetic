Class {
	#name : #PNot,
	#superclass : #Expr,
	#instVars : [
		'p'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
PNot class >> new [
	self shouldNotImplement 
]

{ #category : #'instance creation' }
PNot class >> of: p [
	^self basicNew p: p; yourself 
]

{ #category : #visiting }
PNot >> accept: aVisitor [
	^self class of: (p accept: aVisitor)
]

{ #category : #'term rewriting' }
PNot >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
	^(p evaluateIn: aBindEnv ifUndeclared: vndBlock) not
]

{ #category : #accessing }
PNot >> p [
	^ p
]

{ #category : #accessing }
PNot >> p: anObject [
	p := anObject
]

{ #category : #printing }
PNot >> printOn: aStream [
	aStream nextPut: Character notSign.
	p printOn: aStream 
]

{ #category : #'F.Subable' }
PNot >> subst1: ass [
	^PNot of: (p subst1: ass)
]

{ #category : #'F.Subable' }
PNot >> subst: su [
	^PNot of: (p subst: su)
]
