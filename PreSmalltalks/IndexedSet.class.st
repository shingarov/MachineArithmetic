"
I am a set whose elements are numbered by integer indices.
No two elements have the same index.
When elements are added or removed, the other elements do not change their indices.

An IndexedSet can be thought of as a hotel:
each guest is assigned a room, and no two guests simultaneously share the same room.
However, if a guest moves out, the room *may* be reused.
"
Class {
	#name : #IndexedSet,
	#superclass : #Dictionary,
	#category : #PreSmalltalks
}

{ #category : #API }
IndexedSet >> addElement: anObject [
	"Add anObject.  Answer its newly-assigned index.
	 If anObject is already a member of the receiver,
	 don't add it but simply answer its index."

	^self keyAtValue: anObject ifAbsent: [
		| j |
		j := self availableRoom.
		self at: j put: anObject.
		^j ]
	

]

{ #category : #private }
IndexedSet >> availableRoom [
	self isEmpty ifTrue: [^1].
	^self keys max + 1
]

{ #category : #API }
IndexedSet >> remove: anObject [
	| j |
	j := self keyAtValue: anObject ifAbsent: [ self errorNotFound: anObject ].
	self removeKey: j
]
