"
I represent the type of a function taking exactly one argument
of already-known Z3 sort, and returning an already-known Z3 sort.
"
Class {
	#name : #FuncSort,
	#superclass : #Association,
	#category : #Refinements
}

{ #category : #printing }
FuncSort >> printOn: aStream [
	key printOn: aStream.
	aStream nextPutAll: '⇴'.
	value printOn: aStream
]
