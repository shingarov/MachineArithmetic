Class {
	#name : #Z3Error,
	#superclass : #Error,
	#instVars : [
		'code'
	],
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
Z3Error class >> code: anInteger [
	^ self new code: anInteger
]

{ #category : #accessing }
Z3Error >> code [
	^ code
]

{ #category : #initialization }
Z3Error >> code: anInteger [
	code := anInteger.
]
