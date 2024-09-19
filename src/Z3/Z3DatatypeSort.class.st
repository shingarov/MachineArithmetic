Class {
	#name : #Z3DatatypeSort,
	#superclass : #Z3Sort,
	#instVars : [
		'attrs'
	],
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
Z3DatatypeSort class >> mkTupleSort: constructorName projections: projAssocs mkTupleDecl: tupleDeclCell projDecls: projDeclCell [
	^Z3Context current mkTupleSort: constructorName projections: projAssocs mkTupleDecl: tupleDeclCell projDecls: projDeclCell
]

{ #category : #accessing }
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

{ #category : #accessing }
Z3DatatypeSort >> constructor: idx [
 	"Answer a constructor of the datatype self.
	 NB: idx follows Z3's 0-based convention.
	"
	^ Z3 get_datatype_sort_constructor: ctx _: self _: idx
]

{ #category : #accessing }
Z3DatatypeSort >> constructors [
	^(1 to: self numConstructors) collect: [ :i | self constructor: i-1 ]
]

{ #category : #'function application' }
Z3DatatypeSort >> doesNotUnderstand: aMessage [
	| z3name fn convertedArgs |
	aMessage selector isBinary ifTrue: [ ^self shouldBeImplemented ].
	z3name := aMessage selector z3likeSelector.
	fn := self attrs at: z3name ifAbsent: [ ^super doesNotUnderstand: aMessage ].
	convertedArgs := fn domain collectWithIndex: [ :argSort :j |  argSort cast: (aMessage arguments at: j) ].
	^fn valueWithArguments: convertedArgs
]

{ #category : #accessing }
Z3DatatypeSort >> getTupleSortFieldDecl: i [
	^Z3 get_tuple_sort_field_decl: ctx _: self _: i
]

{ #category : #accessing }
Z3DatatypeSort >> getTupleSortNumFields [
	^Z3 get_tuple_sort_num_fields: ctx _: self
]

{ #category : #GT }
Z3DatatypeSort >> gtInspectorConstructorsIn: composite [
	<gtInspectorPresentationOrder: 40>
	self isTuple ifTrue: [ ^nil ].
	composite fastList
		title: 'Constructors';
		display: [ self constructors ]
]

{ #category : #GT }
Z3DatatypeSort >> gtInspectorTupleFieldsIn: composite [
	<gtInspectorPresentationOrder: 41>
	self isTuple ifFalse: [ ^nil ].
	composite fastList
		title: 'Fields';
		display: [ self tupleFields ]
]

{ #category : #accessing }
Z3DatatypeSort >> isTuple [
	^self numConstructors = 1
]

{ #category : #'type theory' }
Z3DatatypeSort >> nodeClass [
	^ Datatype

]

{ #category : #accessing }
Z3DatatypeSort >> numConstructors [
	^ Z3 get_datatype_sort_num_constructors: ctx _: self

]

{ #category : #accessing }
Z3DatatypeSort >> recognizer: idx [
	"In Z3, each constructor has an associated recognizer predicate.                                                          
	 If the constructor is named `name`, then the recognizer `is_name`.
	 NB: idx follows Z3's 0-based convention.
	"	
	^ Z3 get_datatype_sort_recognizer: ctx _: self _: idx
]

{ #category : #accessing }
Z3DatatypeSort >> tupleFields [
	^(1 to: self getTupleSortNumFields) collect: [ :j | self getTupleSortFieldDecl: j-1 ]
]
