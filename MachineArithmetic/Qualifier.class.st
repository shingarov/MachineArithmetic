Class {
	#name : #Qualifier,
	#superclass : #HThing,
	#instVars : [
		'name',
		'params',
		'body'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
Qualifier class >> name: aString params: aCollection body: pred [
	^self basicNew
		name: aString;
		params: aCollection;
		body: pred;
		yourself

]

{ #category : #'instance creation' }
Qualifier class >> true [
	^self name: 'QTrue' params: #() body: nil
]

{ #category : #'as yet unclassified' }
Qualifier >> addToQuery: q [
	q qualifiers add: self
]

{ #category : #accessing }
Qualifier >> body [
	^ body
]

{ #category : #accessing }
Qualifier >> body: anObject [
	body := anObject
]

{ #category : #accessing }
Qualifier >> name [
	^ name
]

{ #category : #accessing }
Qualifier >> name: anObject [
	name := anObject
]

{ #category : #accessing }
Qualifier >> params [
	^ params
]

{ #category : #accessing }
Qualifier >> params: anObject [
	params := anObject
]
