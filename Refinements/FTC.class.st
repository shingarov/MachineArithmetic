"
I am a brain-damaged Sort which is not a Z3Sort.
The only thing know about me is the type constructor I came from.
Ultimately, all FTCs are elaborated to Z3Sorts before passing to Z3.
"
Class {
	#name : #FTC,
	#superclass : #Object,
	#instVars : [
		'typeConstructor'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FTC class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
FTC class >> new: tc [
	^self basicNew
		typeConstructor: tc;
		yourself
]

{ #category : #comparing }
FTC >> = rhs [
	self class = rhs class ifFalse: [ ^false ].
	^typeConstructor = rhs typeConstructor
]

{ #category : #comparing }
FTC >> hash [
	^typeConstructor hash
]

{ #category : #accessing }
FTC >> typeConstructor [
	^ typeConstructor
]

{ #category : #accessing }
FTC >> typeConstructor: anObject [
	typeConstructor := anObject
]
