"
I am a variable absent in the naming environment.

This is needed when compiling DelayedSubsts:

Imagine we have the DecidableRefinement «x+y», and someone wraps it inside [_:=a],
and now we are trying to compile this DelayedSubst:

«x+y»[_:=a] evaluateIn: Γ

where Γ contains x and y but not a.
DelayedSubst>>evaluateIn: will eagerly (i.e., ignoring the fact that _ is not used
inside «x+y») try to evaluate a to bind at _, but a is not in Γ.
The solution is, bind _ to �a; if it's not used in «x+y», so much the better,
otherwise we at least have an indication of what's wrong.

"
Class {
	#name : #UnknownEVar,
	#superclass : #Object,
	#instVars : [
		'sym'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
UnknownEVar class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
UnknownEVar class >> new: sym [
	^self basicNew
		sym: sym;
		yourself 
]

{ #category : #printing }
UnknownEVar >> printOn: aStream [
	aStream nextPut: Character replacementCharacter; nextPutAll: sym

]

{ #category : #accessing }
UnknownEVar >> sym [
	^ sym
]

{ #category : #accessing }
UnknownEVar >> sym: anObject [
	sym := anObject
]
