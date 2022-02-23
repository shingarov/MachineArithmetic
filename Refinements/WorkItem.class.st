Class {
	#name : #WorkItem,
	#superclass : #Object,
	#instVars : [
		'cId',
		'time',
		'rank'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
WorkItem class >> cId: c time: t rank: r [
	^self basicNew cId: c; time: t; rank: r; yourself 
]

{ #category : #'instance creation' }
WorkItem class >> new [
	self shouldNotImplement 
]

{ #category : #comparing }
WorkItem >> = anotherWI [
	^super = anotherWI "BOGUS"
]

{ #category : #accessing }
WorkItem >> cId [
	^ cId
]

{ #category : #accessing }
WorkItem >> cId: anObject [
	cId := anObject
]

{ #category : #accessing }
WorkItem >> rank [
	^ rank
]

{ #category : #accessing }
WorkItem >> rank: anObject [
	rank := anObject
]

{ #category : #accessing }
WorkItem >> time [
	^ time
]

{ #category : #accessing }
WorkItem >> time: anObject [
	time := anObject
]
