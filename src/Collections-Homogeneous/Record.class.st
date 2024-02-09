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

{ #category : #'instance creation' }
Record class >> new [
	"Prohibited. To create an instance of record class to
	 hold data, use #basicNew. See [1] for explanation.

	[1]: https://github.com/shingarov/MachineArithmetic/pull/188#pullrequestreview-1872166687
	"
	self shouldNotImplement.
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

{ #category : #accessing }
Record >> at: name [
	"Return named element of this record."

	| slots |

	slots := self class slots.
	slots do:[:slot |
		slot name = name ifTrue:[
			^self instVarAt: slot index
		]
	].
	KeyNotFound signalFor: name in: self
]

{ #category : #accessing }
Record >> at: name put: value [
	"Set named element of this record to `value`"

	| slots |

	slots := self class slots.
	slots do:[:slot |
		slot name = name ifTrue:[
			^self instVarAt: slot index	put: value
		]
	].
	KeyNotFound signalFor: name in: self
]

{ #category : #testing }
Record >> isTyped [
	^true
]
