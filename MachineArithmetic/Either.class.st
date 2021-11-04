Class {
	#name : #Either,
	#superclass : #Object,
	#instVars : [
		'x'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Either class >> left: x [ 
	^Left basicNew 
		x: x;
		yourself 
]

{ #category : #'instance creation' }
Either class >> right: x [ 
	^Right basicNew 
		x: x;
		yourself 
]

{ #category : #accessing }
Either >> left: leftBlock right: rightBlock [
	self subclassResponsibility
]

{ #category : #private }
Either >> x: anObject [
	x := anObject
]
