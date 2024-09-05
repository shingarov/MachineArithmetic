Class {
	#name : #PAnyBV,
	#superclass : #'ΛPrim',
	#instVars : [
		'v'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
PAnyBV class >> with: anInteger [ 
	^self basicNew
		v: anInteger;
		yourself
]

{ #category : #accessing }
PAnyBV >> v [
	^ v
]

{ #category : #initialization }
PAnyBV >> v: anInteger [
	v := anInteger
]
