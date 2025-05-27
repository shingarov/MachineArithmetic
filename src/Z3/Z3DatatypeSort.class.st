Class {
	#name : #Z3DatatypeSort,
	#superclass : #Z3Sort,
	#category : #'Z3-Core'
}

{ #category : #'instance creation - convenience' }
Z3DatatypeSort class >> mkEnumerationSort: enumName elements: elements consts: consts testers: testers [
	^Z3Context current
		mkEnumerationSort: enumName
		elements: elements
		consts: consts
		testers: testers
]

{ #category : #'instance creation - convenience' }
Z3DatatypeSort class >> mkListSort: listName elementSort: elementSort nilDecl: nilDecl isNilDecl: isNilDecl consDecl: consDecl isConsDecl: isConsDecl headDecl: headDecl tailDecl: tailDecl [
	^Z3Context current
		mkListSort: listName
		elementSort: elementSort
		nilDecl: nilDecl
		isNilDecl: isNilDecl
		consDecl: consDecl
		isConsDecl: isConsDecl
		headDecl: headDecl
		tailDecl: tailDecl
]

{ #category : #'instance creation - convenience' }
Z3DatatypeSort class >> mkTupleSort: constructorName projections: projAssocs mkTupleDecl: tupleDeclCell projDecls: projDeclCell [
	^Z3Context current
		mkTupleSort: constructorName
		projections: projAssocs
		mkTupleDecl: tupleDeclCell
		projDecls: projDeclCell
]

{ #category : #'instance creation' }
Z3DatatypeSort class >> name: datatypeName constructors: cons [
	| ctx |

	ctx := cons anyOne ctx.
	^ctx mkDatatype: datatypeName constructors: cons
]

{ #category : #'instance creation' }
Z3DatatypeSort class >> named: s [
	^Z3Context current mkDatatypeSort: s
]

{ #category : #'instance creation' }
Z3DatatypeSort class >> names: names constructorLists: clists [
	| sorts ctx |

	sorts := Array new: names size.
	ctx := clists anyOne ctx.
	Z3 mk_datatypes: ctx _: names size _: (names collect: #toZ3Symbol) _: sorts _: clists.
	^sorts
]

{ #category : #accessing }
Z3DatatypeSort >> accessor: i idx: j [ 
	^ Z3 get_datatype_sort_constructor_accessor: ctx _: self _: i _: j
]

{ #category : #accessing }
Z3DatatypeSort >> accessorNamed: aString [
	"Return an accessor for 'field' (member) with given name.
	 
	 Note. that if multiple constructors define the same 'field',
	 then this method throws an error."


	| accessors |
	
	accessors := self allAccessors select: [ :f | f name = aString ].
	accessors isEmpty ifTrue:[ self error: 'No accessor named ', aString ].
	accessors size > 1 ifTrue:[ self error: 'Ambiguous accessor name]' ].

	^accessors anyOne
]

{ #category : #accessing }
Z3DatatypeSort >> allAccessors [
	^(self structure values collect: #third) concat
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
Z3DatatypeSort >> constructorNamed: aString [
	^self constructors detect: [ :c | c name = aString ]
]

{ #category : #accessing }
Z3DatatypeSort >> constructors [
	^(1 to: self numConstructors) collect: [ :i | self constructor: i-1 ]
]

{ #category : #accessing }
Z3DatatypeSort >> fieldsOf: constructorNameString [
	| c_r_fs |
	c_r_fs := self structure at: constructorNameString.
	^c_r_fs third
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

{ #category : #testing }
Z3DatatypeSort >> isDatatypeSort [
	^ true
]

{ #category : #accessing }
Z3DatatypeSort >> isTuple [
	^self numConstructors = 1
]

{ #category : #'type theory' }
Z3DatatypeSort >> nodeClass [
	^self isTuple
		ifTrue: [ Z3Tuple ]
		ifFalse: [ Datatype ]

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
Z3DatatypeSort >> recognizerFor: constructorNameString [
	| c_r_fs |
	c_r_fs := self structure at: constructorNameString.
	^c_r_fs second
]

{ #category : #accessing }
Z3DatatypeSort >> recognizers [
	^(1 to: self numConstructors) collect: [ :i | self recognizer: i-1 ]
]

{ #category : #accessing }
Z3DatatypeSort >> structure [
	"Answer a Dictionary keyed by constructor names.
	 Each value is a triple, { constructor . recognizer . accessors }.
	 Constructor is a Z3FuncDecl of the injection morphism.
	 Recognizer is a Z3FuncDecl :: D→𝔹.
	 Accessors is an Array of Z3FuncDecls :: D→F where F is the field's sort."
	^Dictionary newFromAssociations:
	((1 to: self numConstructors) collect: [ :i |
		| constructor recognizer accessors |
		constructor := self constructor: i-1.
		recognizer := self recognizer: i-1.
		accessors := (0 to: constructor arity - 1) collect: [ :j | self accessor: i-1 idx: j ].
		constructor name -> { constructor . recognizer . accessors }
	])
]

{ #category : #accessing }
Z3DatatypeSort >> tupleFields [
	^(1 to: self getTupleSortNumFields) collect: [ :j | self getTupleSortFieldDecl: j-1 ]
]
