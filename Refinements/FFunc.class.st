"
I am a brain-damaged function Sort which is not a Z3Sort.
"
Class {
	#name : #FFunc,
	#superclass : #PreSort,
	#instVars : [
		'from',
		'to'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FFunc class >> from: dom to: cod [
	^self basicNew
		from: dom;
		to: cod;
		yourself
]

{ #category : #accessing }
FFunc >> from [
	^ from
]

{ #category : #accessing }
FFunc >> from: anObject [
	from := anObject
]

{ #category : #printing }
FFunc >> printOn: aStream [
	aStream nextPut: $(.
	from printOn: aStream.
	aStream nextPut: (Character codePoint: 16r2192).
	to printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #accessing }
FFunc >> to [
	^ to
]

{ #category : #accessing }
FFunc >> to: anObject [
	to := anObject
]
