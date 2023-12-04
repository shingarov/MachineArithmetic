"
Datatype to be ultimately represented in Z3 datatypes.

Instance Variables
	name  ::  Ident                 --  name of the datatype
	vars  ::		[Ident]              --  type variables
	rvars ::		[RVar]               --  refinement variables
	ctors ::		[(Bind a, RType)]    --  constructors
	inv   ::		Reft                 --  data invariant
"
Class {
	#name : #Data,
	#superclass : #Object,
	#instVars : [
		'name',
		'vars',
		'rvars',
		'ctors',
		'inv'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
Data class >> name: ident vars: idents rvars: rvars ctors: bindToRType_Assocs inv: inv [
	^self basicNew
		name: ident;
		vars: idents;
		rvars: rvars;
		ctors: bindToRType_Assocs;
		inv: inv;
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

{ #category : #'as yet unclassified' }
Data >> dataSigs [
"
dataSigs :: SrcData -> [(F.Symbol, RType)]
dataSigs (Data _ _ ctors) = [(F.symbol b, t) | (b, t) <- ctors]
"
	^ctors collectAssociations: [ :b :t | b id -> t ] 
]

{ #category : #accessing }
Data >> inv [
	^ inv
]

{ #category : #accessing }
Data >> inv: anObject [
	inv := anObject
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
Data >> rvars [
	^ rvars
]

{ #category : #accessing }
Data >> rvars: anObject [
	rvars := anObject
]

{ #category : #accessing }
Data >> vars [
	^ vars
]

{ #category : #accessing }
Data >> vars: anObject [
	vars := anObject
]
