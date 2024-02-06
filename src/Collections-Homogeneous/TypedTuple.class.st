Class {
	#name : #TypedTuple,
	#superclass : #Object,
	#type : #variable,
	#category : #'Collections-Homogeneous'
}

{ #category : #'instance creation' }
TypedTuple class >> new [
	self == TypedTuple ifTrue:[self shouldNotImplement].
	^super new
	
	"
	(TypedTuple ofAll:{ #x -> String }) new
	(TypedTuple) new
	"
]

{ #category : #'subclass creation' }
TypedTuple class >> ofAll: elementNamesAndTypes [
	| tupleName tupleSlots tupleClass |
	elementNamesAndTypes do:[:nameAndType | 
		self assert: (nameAndType isKindOf: Association).
		self assert: nameAndType key isString.
		self assert: nameAndType value isClass.
	].

	tupleName := 'TypedTuple of: ' , elementNamesAndTypes asArray storeString.
	tupleSlots := elementNamesAndTypes collect:
								[:nameAndType | TypedTupleSlot named: nameAndType key type: nameAndType value].
	[
	tupleClass := self classBuilder
								name: tupleName;								
								superclass: self;
								slots: tupleSlots;
								build.
	] on: InvalidGlobalName do:[:ex|
		ex resumeUnchecked: nil.
	].
	^tupleClass
	
	"
	TypedTuple ofAll:{ #x -> Integer . #y -> Integer }
	"
	
]

{ #category : #testing }
TypedTuple >> isTyped [
	^true
]
