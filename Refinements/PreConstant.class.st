Class {
	#name : #PreConstant,
	#superclass : #Object,
	#instVars : [
		'name',
		'sort'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
PreConstant class >> name: n sort: s [
	^self basicNew 
		name: n;
		sort: s;
		yourself
]

{ #category : #elaboration }
PreConstant >> elab: anElabEnv [
	"In LH this is a call to checkSym.
	 We can't do a stronger assert because our own sort
	 may be the  not-yet-evaluated polymorphic sort
	 (something like FAbs 0 ((FApp l @(0))→ℤ)) but someone
	 else might have already elaborated it (e.g. all the way
	 to a Z3Sort)."
	"| sortInEnv |
	sortInEnv := anElabEnv senv sort at: name.
	sortInEnv = sort ifFalse: [ self error ]."
	^{ EVar of: name . sort instantiate }
]

{ #category : #testing }
PreConstant >> isConstantNamed: aString [ 
	^name = aString
]

{ #category : #accessing }
PreConstant >> name [
	^ name
]

{ #category : #accessing }
PreConstant >> name: anObject [
	name := anObject
]

{ #category : #printing }
PreConstant >> printOn: aStream [
	aStream nextPutAll: 'PreConst '.
	aStream nextPutAll: name.
	aStream nextPutAll: ' ∈ '.
	sort printOn: aStream

]

{ #category : #accessing }
PreConstant >> sort [
	^ sort
]

{ #category : #accessing }
PreConstant >> sort: anObject [
	sort := anObject
]

{ #category : #'function application' }
PreConstant >> value: arg [
	^EApp expr: self imm: arg
]

{ #category : #'function application' }
PreConstant >> value: arg1 value: arg2 [
	self shouldBeImplemented
]
