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
	"Prohibited. To create an instance of tuple class to
	 hold data, use #basicNew. See [1] for explanation.

	[1]: https://github.com/shingarov/MachineArithmetic/pull/188#pullrequestreview-1872166687
	"
	self shouldNotImplement.
]

{ #category : #'subclass creation' }
Tuple class >> ofAll: types [
	| tupleName |
	tupleName := 'TypedTuple ofAll: ' , types asArray storeString.
	^self ofAll: types named: tupleName
]

{ #category : #'subclass creation' }
Tuple class >> ofAll: types named: aName [
	| tupleSlots tupleClass |

	tupleSlots := types withIndexCollect: [:type :index | TypedSlot named: index printString type: type ].
	[
	tupleClass := self classBuilder
								name: aName;								
								superclass: self;
								slots: tupleSlots;
								build.
	] on: InvalidGlobalName do:[:ex|
		ex resumeUnchecked: nil.
	].
	^tupleClass
	
	"
	Tuple ofAll:{ Integer . Integer }
	"
	
]

{ #category : #accessing }
Tuple class >> slotAssociations [
	^self slots collect: [ :eachSlot | eachSlot name -> eachSlot type ]
]

{ #category : #accessing }
Tuple >> at: index [
	"Return index-th element of this tuple"
	| slots |

	index isInteger ifFalse:[
		self errorNonIntegerIndex.
		^nil.
	].

	slots := self class slots.

	(index between: 1 and: slots size) ifFalse:[
		self errorSubscriptBounds: index
	].

	^self instVarAt: (slots at: index) index.

]

{ #category : #accessing }
Tuple >> at: index put: value [
	"Set index-th element of this tuple to value"
	| slots |

	index isInteger ifFalse:[
		self errorNonIntegerIndex.
		^nil.
	].

	slots := self class slots.

	(index between: 1 and: slots size) ifFalse:[
		self errorSubscriptBounds: index
	].

	^self instVarAt: (slots at: index) index put: value

]

{ #category : #testing }
Tuple >> isTyped [
	^true
]
