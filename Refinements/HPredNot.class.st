Class {
	#name : #HPredNot,
	#superclass : #HPred,
	#instVars : [
		'p'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
HPredNot class >> new [
	self shouldNotImplement 
]

{ #category : #'instance creation' }
HPredNot class >> of: p [
	^self basicNew p: p; yourself 
]

{ #category : #visiting }
HPredNot >> accept: aVisitor [
	^self class of: (p accept: aVisitor)
]

{ #category : #'term rewriting' }
HPredNot >> evaluateIn: aBindEnv [ 
	^(p evaluateIn: aBindEnv) not
]

{ #category : #accessing }
HPredNot >> p [
	^ p
]

{ #category : #accessing }
HPredNot >> p: anObject [
	p := anObject
]

{ #category : #'F.Subable' }
HPredNot >> subst1: ass [
	^HPredNot of: (p subst1: ass)
]

{ #category : #'as yet unclassified' }
HPredNot >> substPred: oldToNewVarNameAssocs [
	^(p substPred: oldToNewVarNameAssocs) not
]
