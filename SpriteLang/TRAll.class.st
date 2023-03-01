Class {
	#name : #TRAll,
	#superclass : #RType,
	#instVars : [
		'r',
		't'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
TRAll class >> r: r t: t [
	^self basicNew
		r: r;
		t: t;
		yourself
]

{ #category : #accessing }
TRAll >> r [
	^ r
]

{ #category : #accessing }
TRAll >> r: anObject [
	r := anObject
]

{ #category : #accessing }
TRAll >> t [
	^ t
]

{ #category : #accessing }
TRAll >> t: anObject [
	t := anObject
]
