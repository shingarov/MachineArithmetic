"
I am a single-assign cell holding an object.
The protocol is as follows: a cell is initially created
by sending 'Cell new'.  This fresh cell is empty i.e.
does not hold any object (not even nil), and attempts
to 'cell get' would result in an Error.
After 'cell set: anObject' the cell now holds anObject,
which can be retrieved any number of times by sending
'cell get', but attempts to modify the contents would
now result in a ModificationForbidden.

This class is part of Newtonian Smalltalk-80; the
corresponding Smalltalk-25 notion is Lens.  Cell is
here to assist the Z3 layer (at which MachineArithmetic
is not available).

"
Class {
	#name : #Cell,
	#superclass : #Object,
	#instVars : [
		'contents'
	],
	#classVars : [
		'Unset'
	],
	#category : #PreSmalltalks
}

{ #category : #'class initialization' }
Cell class >> initialize [
	Unset := 'Contents have not been set yet' copy
]

{ #category : #'instance creation' }
Cell class >> new [
	^ self basicNew initialize
]

{ #category : #accessing }
Cell >> get [
	self isEmpty ifTrue: [ self error: Unset ].
	^contents
]

{ #category : #initialization }
Cell >> initialize [
	contents := Unset
]

{ #category : #testing }
Cell >> isEmpty [
	^contents == Unset
]

{ #category : #printing }
Cell >> printOn: aStream [
	self isEmpty
		ifTrue: [ aStream nextPutAll: 'Empty cell' ]
		ifFalse: [ aStream nextPutAll: 'Cell('. contents printOn: aStream. aStream nextPutAll: ')' ]
]

{ #category : #accessing }
Cell >> set: anObject [
	self isEmpty ifFalse: [ self error: 'Attempt to reassign already assigned contents' ].
	contents := anObject
]
