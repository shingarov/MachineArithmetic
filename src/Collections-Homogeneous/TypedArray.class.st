Class {
	#name : #TypedArray,
	#superclass : #Array,
	#type : #variable,
	#classVars : [
		'Arrays'
	],
	#classInstVars : [
		'elementSpecies'
	],
	#category : #'Collections-Homogeneous'
}

{ #category : #accessing }
TypedArray class >> elementSpecies [
	^elementSpecies
]

{ #category : #accessing }
TypedArray class >> elementSpecies: aClass [
	self assert: aClass isClass.
	self assert: self ~~ TypedArray. 
	self assert: elementSpecies isNil.

	elementSpecies := aClass
]

{ #category : #initialization }
TypedArray class >> initialize [
	Arrays := SystemDictionary new.
]

{ #category : #JSON }
TypedArray class >> neoJsonMapping: mapper [
	mapper for: self customDo: [ :mapping |
		mapping listOfElementSchema: elementSpecies
	]
]

{ #category : #'instance creation' }
TypedArray class >> new: size [
	self == TypedArray ifTrue:[ self shouldNotImplement ].
	^super new: size.
	
	"
	(TypedArray of: String) new:10.
	TypedArray new:10.
	"
	
	
]

{ #category : #'subclass creation' }
TypedArray class >> of: aClass [
	| arrayName arrayClass |
	
	self assert: aClass isClass.
	
	arrayName := ('Array of: ', aClass name) asSymbol.
	[ 
	arrayClass := self classBuilder
								name: arrayName;
								superclass: self;
								build.
	] on: InvalidGlobalName do:[:ex|
		ex resumeUnchecked: nil.
	].
								
	arrayClass elementSpecies: aClass.
	^arrayClass
	
	"
	Array of: String
	"
								
								
								
			
		
	
	
	
	
	
]

{ #category : #testing }
TypedArray >> isTyped [
	^true
]
