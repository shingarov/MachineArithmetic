Class {
	#name : #Z3ParameterDescription,
	#superclass : #Object,
	#instVars : [
		'name',
		'kind',
		'documentation'
	],
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
Z3ParameterDescription class >> name: nameArg kind: kindArg documentation: docArg [
	^ self basicNew name: nameArg kind: kindArg documentation: docArg
]

{ #category : #accessing }
Z3ParameterDescription >> documentation [
	^ documentation
]

{ #category : #accessing }
Z3ParameterDescription >> kind [
	^ kind
]

{ #category : #accessing }
Z3ParameterDescription >> name [
	^ name
]

{ #category : #initialization }
Z3ParameterDescription >> name: nameArg kind: kindArg documentation: docArg [
	name := nameArg asString.
	kind := kindArg.
	documentation := docArg
]

{ #category : #'printing & storing' }
Z3ParameterDescription >> printOn:aStream [
	"append a printed representation of the receiver to the argument, aStream"

	super printOn:aStream.
	aStream nextPut:$(; nextPut:$'.
	name printOn:aStream.
	aStream space; nextPut:$[.
	(Z3ParameterKind kindToName:kind) printOn:aStream.
	aStream nextPut:$].
	aStream nextPut:$:; space.
	documentation printOn:aStream.
	aStream  nextPut:$'; nextPut:$).
]
