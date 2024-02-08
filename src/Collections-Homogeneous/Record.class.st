Class {
	#name : #Record,
	#superclass : #Object,
	#type : #variable,
	#category : #'Collections-Homogeneous'
}

{ #category : #'subclass creation' }
Record class >> empty [
	^self ofAll: #()
]

{ #category : #'subclass creation' }
Record class >> ofAll: typings [
	| recordName recordSlots recordClass |
	
	recordSlots := typings collect: #asSlot as:Array.
	recordName := String streamContents:[:s |
		s nextPutAll: 'Record ofAll: {'.
		recordSlots do:[:slot | s nextPutAll: slot definitionString ] separatedBy:[s nextPut:$.;space].
		s nextPut: $}.
	].
	[
	recordClass := self classBuilder
								name: recordName;								
								superclass: self;
								slots: recordSlots;
								build.
	] on: InvalidGlobalName do:[:ex|
		ex resumeUnchecked: nil.
	].
	^recordClass
	
	"
	Record ofAll:{ #x ∷ Integer . #y ∷ Integer }
	"
	
]

{ #category : #testing }
Record >> isTyped [
	^true
]
