Class {
	#name : #TBVal,
	#superclass : #TrieBranch,
	#instVars : [
		'a'
	],
	#category : #'PreSmalltalks-Pharo'
}

{ #category : #'instance creation' }
TBVal class >> of: a [
	^self basicNew
		a: a;
		yourself
]

{ #category : #accessing }
TBVal >> a [
	^ a
]

{ #category : #accessing }
TBVal >> a: anObject [
	a := anObject
]

{ #category : #printing }
TBVal >> printOn: aStream [
	aStream nextPutAll: 'Val '.
	a printOn: aStream.
]
