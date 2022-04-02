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

{ #category : #'term rewriting' }
HPredNot >> evaluateIn: aBindEnv [ 
	^(p evaluateIn: aBindEnv) not
]

{ #category : #'term rewriting' }
HPredNot >> mapKVarSubsts: twoArgumentBlock [
	^self class of: (p mapKVarSubsts: twoArgumentBlock)
]

{ #category : #accessing }
HPredNot >> p [
	^ p
]

{ #category : #accessing }
HPredNot >> p: anObject [
	p := anObject
]
