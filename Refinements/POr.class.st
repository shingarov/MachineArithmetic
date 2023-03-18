Class {
	#name : #POr,
	#superclass : #Expr,
	#instVars : [
		'disjuncts'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
POr class >> of: disjuncts [
	^self basicNew
		disjuncts: disjuncts;
		yourself
]

{ #category : #accessing }
POr >> disjuncts [
	^ disjuncts
]

{ #category : #accessing }
POr >> disjuncts: anObject [
	disjuncts := anObject
]
