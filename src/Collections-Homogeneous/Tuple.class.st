Class {
	#name : #Tuple,
	#superclass : #Object,
	#type : #variable,
	#category : #'Collections-Homogeneous'
}

{ #category : #'subclass creation' }
Tuple class >> empty [
	^self ofAll: #()
]

{ #category : #JSON }
Tuple class >> neoJsonMapping: mapper [
	mapper for: self customDo: [ :mapping | mapping reader: [ :jsonReader |
			| stillLeft acc inst |

			stillLeft := self slots asOrderedCollection.
			acc := OrderedCollection new.
			
			jsonReader parseListDo: [ acc addLast: (jsonReader nextAs: stillLeft first type).  stillLeft removeFirst ].
			stillLeft isEmpty ifFalse: [self error].
			inst := self basicNew.
			acc withIndexDo: [ :eachValue :j | inst instVarAt: j put: eachValue ].
			inst
		]].
]

{ #category : #'instance creation' }
Tuple class >> new [
	"Use #ofAll: or #empty."
	self shouldNotImplement
]

{ #category : #'subclass creation' }
Tuple class >> ofAll: elementNamesAndTypes [
	| tupleName tupleSlots tupleClass |
	elementNamesAndTypes do:[:nameAndType | 
		self assert: (nameAndType isKindOf: Association).
		self assert: nameAndType key isString.
		self assert: nameAndType value isClass.
	].

	tupleName := 'TypedTuple of: ' , elementNamesAndTypes asArray storeString.
	tupleSlots := elementNamesAndTypes collect:
								[:nameAndType | TypedSlot named: nameAndType key type: nameAndType value].
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

{ #category : #accessing }
Tuple class >> slotAssociations [
	^self slots collect: [ :eachSlot | eachSlot name -> eachSlot type ]
]

{ #category : #semigroup }
Tuple class >> ⨰ [ anotherClass
	anotherClass isClass ifFalse: [ self shouldBeImplemented "A×(B×C) case" ].
	^Tuple ofAll:
		self slotAssociations, { '_', (self instSize + 1) printString -> anotherClass } 
]

{ #category : #testing }
Tuple >> isTyped [
	^true
]
