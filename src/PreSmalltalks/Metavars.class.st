"
I encode a culture of default variable name conventions by type,
similar to how in FORTRAN the integers are taken (by default, but
can be overridden) to be I,J,K,L,M,N.

Similarly, the Ott codebase follows the convention that i stands
for ""any integer variable"", l is ""any loc"", etc.

This first implementation is extremely primitive, allowing for
one global convention.  This will be changed in the future.
"
Class {
	#name : #Metavars,
	#superclass : #Dictionary,
	#classInstVars : [
		'current'
	],
	#category : #PreSmalltalks
}

{ #category : #'instance creation' }
Metavars class >> current [
	current isNil ifTrue: [ current := self new ].
	^current
]

{ #category : #'instance creation' }
Metavars class >> setCurrentFromAssociations: as [
	current := self newFromAssociations: as
]
