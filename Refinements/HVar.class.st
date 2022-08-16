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

{ #category : #'function application' }
HVar >> value [
	^self valueWithArguments: #()
]

{ #category : #'function application' }
HVar >> value: arg [
	^self valueWithArguments: {arg}
]

{ #category : #'function application' }
HVar >> value: arg1 value: arg2 [
	^self valueWithArguments: {arg1. arg2}
]

{ #category : #'function application' }
HVar >> value: arg1 value: arg2 value: arg3 [
	^self valueWithArguments: {arg1. arg2. arg3}
]

{ #category : #'function application' }
HVar >> value: arg1 value: arg2 value: arg3 value: arg4 [
	^self valueWithArguments: {arg1. arg2. arg3. arg4}
]

{ #category : #'function application' }
HVar >> valueWithArguments: args [
	"Create a Smalltalk-side representation of the receiver
	 to args, without creating an actual Z3 APP_AST node.
	NB: Each arg must be a (literal or symbolic) constant
	(i.e. something like 'x' toInt); effectively forcing ANF."
	^RefVarApp var: self name args: (args collect: #sym)
]
