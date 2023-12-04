"
I may be signaled when an elim on a cyclic constraint is attempted.
"
Class {
	#name : #CyclicConstraint,
	#superclass : #Error,
	#category : #Refinements
}

{ #category : #'exception description' }
CyclicConstraint >> isResumable [
	^true
]
