"
I am a brain-damaged Sort which is not a Z3Sort.
The only thing known about me is the type constructor I came from.
Ultimately, all FTCs are elaborated to Z3Sorts before passing to Z3.
"
Class {
	#name : #FTC,
	#superclass : #PreSort,
	#instVars : [
		'typeConstructor'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FTC class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
FTC class >> new: tc [
	^self basicNew
		typeConstructor: tc;
		yourself
]

{ #category : #comparing }
FTC >> = rhs [
	self class = rhs class ifFalse: [ ^false ].
	^typeConstructor = rhs typeConstructor
]

{ #category : #'as yet unclassified' }
FTC >> checkEqConstr: aBlockClosure maybeExpr: anUndefinedObject tvSubst: aCollection symbol: aString [ 
	^nil "BOGUS?"
]

{ #category : #'as yet unclassified' }
FTC >> containsFVar [
	^false
]

{ #category : #hotel }
FTC >> fappSmtSort: ts originalFApp: anFApp [
	| j |
	self isSetCon ifTrue: [
		ts size = 1 ifFalse: [ self error ].
		^ts first z3sort mkSetSort
	].
	self isMapCon ifTrue: [ self shouldBeImplemented ].
	self isBitVec ifTrue: [ self shouldBeImplemented ].

	j := PreSort hotel addElement: anFApp.
	^Z3Sort uninterpretedSortNamed: j
]

{ #category : #comparing }
FTC >> hash [
	^typeConstructor hash
]

{ #category : #theories }
FTC >> isBitVec [
"
Cf. fappSmtSort in Theories.hs
"
	^typeConstructor symbol = 'BitVec'
]

{ #category : #theories }
FTC >> isMapCon [
"
Cf. fappSmtSort in Theories.hs
"
	^typeConstructor symbol = 'Map_t'
]

{ #category : #theories }
FTC >> isSetCon [
"
Cf. fappSmtSort in Theories.hs
"
	^typeConstructor symbol = 'Set_Set'
]

{ #category : #printing }
FTC >> printOn: aStream [
	aStream nextPutAll: 'FTC ('.
	typeConstructor printOn: aStream.
	aStream nextPutAll: ')'.
]

{ #category : #substitution }
FTC >> sortSubst: θ [
"TODO: investigate.
What if the type constructor is variable, so we need to unify??
For now, just ignore this."
	^self
]

{ #category : #substitution }
FTC >> subst: j _: tj [
	^self
]

{ #category : #accessing }
FTC >> typeConstructor [
	^ typeConstructor
]

{ #category : #accessing }
FTC >> typeConstructor: anObject [
	typeConstructor := anObject
]

{ #category : #hotel }
FTC >> z3sort [
	| h j |
	h := PreSort hotel.
	j := h addElement: self.
	^Z3Sort uninterpretedSortNamed: j
]
