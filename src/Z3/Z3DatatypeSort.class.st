Class {
	#name : #Z3DatatypeSort,
	#superclass : #Z3Sort,
	#instVars : [
		'attrs',
		'components'
	],
	#category : #'Z3-Core'
}

{ #category : #'as yet unclassified' }
Z3DatatypeSort >> accessor: i idx: j [ 
	^ Z3 get_datatype_sort_constructor_accessor: ctx _: self _: i _: j
]

{ #category : #attributes }
Z3DatatypeSort >> at: attrName put: attrValue [
	^self attrs at: attrName put: attrValue
]

{ #category : #attributes }
Z3DatatypeSort >> attrs [
	attrs isNil ifTrue: [ attrs := Dictionary new ].
	^attrs
]

{ #category : #'type theory' }
Z3DatatypeSort >> cast: val [
	^val toDatatype: self
]

{ #category : #private }
Z3DatatypeSort >> components [
	^ components
]

{ #category : #'F-Algebra' }
Z3DatatypeSort >> constructor: idx [
 	"Answer a constructor of the datatype self.
	 NB: idx follows Z3's 0-based convention.
	"
	^ Z3 get_datatype_sort_constructor: ctx _: self _: idx
]

{ #category : #'function application' }
Z3DatatypeSort >> doesNotUnderstand: aMessage [
	| z3name fn convertedArgs |
	aMessage selector isBinary ifTrue: [ ^self shouldBeImplemented ].
	z3name := aMessage selector z3likeSelector.
	fn := self attrs at: z3name ifAbsent: [ ^super doesNotUnderstand: aMessage ].
	convertedArgs := fn domain collectWithIndex: [ :argSort :j |  argSort cast: (aMessage arguments at: j) ].
	^fn valueWithArguments: convertedArgs

{ #category : #initialization }
Z3DatatypeSort >> initializeWithAddress: anExternalAddress context: aZ3Context [
	super initializeWithAddress: anExternalAddress context: aZ3Context.
	components := SmallDictionary new.
	

]

{ #category : #'type theory' }
Z3DatatypeSort >> nodeClass [
	^ Datatype

]

{ #category : #'F-Algebra' }
Z3DatatypeSort >> numConstructors [
	^ Z3 get_datatype_sort_num_constructors: ctx _: self

]

{ #category : #'as yet unclassified' }
Z3DatatypeSort >> recognizer: idx [
	"In Z3, each constructor has an associated recognizer predicate.                                                          
	 If the constructor is named `name`, then the recognizer `is_name`.
	 NB: idx follows Z3's 0-based convention.
	"	
	^ Z3 get_datatype_sort_recognizer: ctx _: self _: idx
]
