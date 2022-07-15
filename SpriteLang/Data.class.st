"
Datatype to be ultimately represented in Z3 datatypes.

Instance Variables
	name  ::  Ident                 --  name of the datatype
	vars  ::		[Ident]               --  type variables
	ctors ::		[(Bind a, RType)]     --  constructors
"
Class {
	#name : #Data,
	#superclass : #Object,
	#instVars : [
		'name',
		'vars',
		'ctors'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
Data class >> name: ident vars: idents ctors: bindToRType_Assocs [
	^self basicNew
		name: ident;
		vars: idents;
		ctors: bindToRType_Assocs;
		yourself
]

{ #category : #accessing }
Data >> ctors [
	^ ctors
]

{ #category : #accessing }
Data >> ctors: anObject [
	ctors := anObject
]

{ #category : #accessing }
Data >> name [
	^ name
]

{ #category : #accessing }
Data >> name: anObject [
	name := anObject
]

{ #category : #accessing }
Data >> vars [
	^ vars
]

{ #category : #accessing }
Data >> vars: anObject [
	vars := anObject
]
