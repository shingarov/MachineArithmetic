Class {
	#name : #Z3Datatype,
	#superclass : #Object,
	#instVars : [
		'name',
		'constructors'
	],
	#category : #'Z3-Core'
}

{ #category : #'as yet unclassified' }
Z3Datatype class >> createDatatypes: datatypes [
	| num datatypeSorts ctorLists toDelete drefs |
	toDelete := OrderedCollection new.
	num := datatypes size.
	ctorLists := datatypes collect: [ :d |
		| ctors ctorList |
		ctors := d constructors collect: [ :c |
			| ctorName recognizerName ctorFields fsrs  ctorFieldNames ctorFieldSorts ctorFieldSortRefs ctor |
			ctorName := c first toZ3Symbol.
			recognizerName := c second toZ3Symbol.
			ctorFields := c last.
			fsrs := ctorFields collect: [ :f |
				| fname ftype |
				fname := f key.
				ftype := f value.
				{fname toZ3Symbol}, (ftype sort_reft: datatypes) ].
			fsrs := fsrs unzip: 3.
			ctorFieldNames := fsrs first. ctorFieldSorts := fsrs second. ctorFieldSortRefs := fsrs third.
			ctor := Z3 mk_constructor: Z3Context current
				_: ctorName
				_: recognizerName
				_: ctorFields size
				_: ctorFieldNames
				_: ctorFieldSorts
				_: ctorFieldSortRefs.
			"TODO: to_delete.append(ScopedConstructor(cs[j], ctx))"
			ctor ].
		ctorList := Z3 mk_constructor_list: Z3Context current
			_: ctors size
			_: ctors.
		"to_delete.append(ScopedConstructorList(clists[i], ctx))"
		ctorList ].
	datatypeSorts := Array new: num.
	Z3 mk_datatypes: Z3Context current
		_: num
		_: ((datatypes collect: #name) collect: #toZ3Symbol)
		_: datatypeSorts
		_: ctorLists.
	
	datatypeSorts do: [ :datatypeSort |
		(0 to: datatypeSort numConstructors - 1) do: [ :ctorIndex |
			| ctorFunc ctorName ctorArity recognizerFunc accessorFuncs datatypeComponent |			
			ctorFunc := datatypeSort constructor: ctorIndex.			
			ctorName := ctorFunc name.
			ctorArity := ctorFunc arity.
			recognizerFunc := datatypeSort recognizer: ctorIndex.
			accessorFuncs := 
				(0 to: ctorArity - 1) collect: 
					[:accessorIndex | datatypeSort accessor: ctorIndex idx: accessorIndex ].
				
			"New style, create 'component'"
			datatypeComponent := Z3DatatypeComponent new.
			datatypeComponent constructor: ctorFunc; recognizer: recognizerFunc; accessors: accessorFuncs.			 
			datatypeSort components at: datatypeComponent name put: datatypeComponent. 
						
			"Old style kept for compatibility"
			datatypeSort at: ctorName put: ctorFunc.
			datatypeSort at: 'is_', ctorName put: recognizerFunc.
			accessorFuncs do: [:accessorFunc | datatypeSort at: accessorFunc name put: accessorFunc ]
		].
	].
	^datatypeSorts

]

{ #category : #'instance creation' }
Z3Datatype class >> named: aString [
	^self basicNew
		name: aString;
		constructors: OrderedCollection new;
		yourself
]

{ #category : #accessing }
Z3Datatype >> constructors [
	^ constructors
]

{ #category : #accessing }
Z3Datatype >> constructors: anObject [
	constructors := anObject
]

{ #category : #'as yet unclassified' }
Z3Datatype >> create [
	"Create a Z3 datatype based on the constructors declared #declare:.                                    
	 Z3Datatype class>>createDatatypes: must be used to define mutually recursive datatypes."
	^(Z3Datatype createDatatypes: {self}) first
]

{ #category : #'as yet unclassified' }
Z3Datatype >> declare: constructorName [
	self declare: constructorName accessors: #()
]

{ #category : #'as yet unclassified' }
Z3Datatype >> declare: constructorName accessors: assocs [ 
	self declareCore: constructorName recognizer: 'is-', constructorName accessors: assocs
]

{ #category : #'as yet unclassified' }
Z3Datatype >> declareCore: constructorName recognizer: rec_name accessors: assocs [ 
	constructors addLast: { constructorName . rec_name . assocs }
]

{ #category : #accessing }
Z3Datatype >> name [
	^ name
]

{ #category : #accessing }
Z3Datatype >> name: anObject [
	name := anObject
]

{ #category : #printing }
Z3Datatype >> printOn: aStream [
	aStream nextPutAll: 'Datatype '.
	aStream nextPutAll: self name
]

{ #category : #'as yet unclassified' }
Z3Datatype >> sort_reft: knownDatatypes [
	(knownDatatypes occurrencesOf: self) = 1 ifFalse: [ self error: 'One and only one occurrence of each datatype is expected' ].
	^{nil . (knownDatatypes indexOf: self) - 1}
]
