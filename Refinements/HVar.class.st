Class {
	#name : #HVar,
	#superclass : #HThing,
	#instVars : [
		'name',
		'domain'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
HVar class >> name: aString argSorts: sorts [
	^self basicNew
		name: aString;
		domain: sorts;
		yourself
]

{ #category : #adding }
HVar >> addToQuery: q [ 
	q addVar: self
]

{ #category : #accessing }
HVar >> domain [
	^ domain
]

{ #category : #accessing }
HVar >> domain: sorts [
	domain := sorts toProduct
]

{ #category : #'as yet unclassified' }
HVar >> formalArguments [
	"Invent unique names for the receiver's arguments, such as
	  nnf_argººκºº0,
	  nnf_argººκºº1,
	 etc.      ^
	           +--- kvar name
	 Associate each name to its sort.
	 Answer the Array of these associations (in argument order).
	"

	^self domain inventFormalArgumentsFor: self name
]

{ #category : #accessing }
HVar >> name [
	^ name
]

{ #category : #accessing }
HVar >> name: aString [
	name := aString
]

{ #category : #printing }
HVar >> printOn: aStream [
	aStream nextPutAll: '(var $'.
	aStream nextPutAll: name.
	aStream nextPutAll: ' '.
	domain printElementsOn: aStream.
	aStream nextPutAll: ')'
]
