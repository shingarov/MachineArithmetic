Class {
	#name : #FqExpand,
	#superclass : #Array,
	#type : #variable,
	#instVars : [
		'associations'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FqExpand class >> associations: ass [
	^self basicNew
		associations: ass;
		yourself
]

{ #category : #accessing }
FqExpand >> associations [
	^ associations
]

{ #category : #accessing }
FqExpand >> associations: anObject [
	associations := anObject
]
