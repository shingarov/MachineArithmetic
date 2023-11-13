Class {
	#name : #Z3Datatype,
	#superclass : #Object,
	#instVars : [
		'name',
		'ctx',
		'constructors'
	],
	#category : #'Z3-Core'
}

{ #category : #'as yet unclassified' }
Z3Datatype class >> createDatatypes: ds [
	| num out clists toDelete drefs |
	toDelete := OrderedCollection new.
	num := ds size.
	clists := ds collect: [ :d |
		| cs clist |
		cs := d constructors collect: [ :c |
			| cname rname fs fsrs  fnames sorts refs z3c |
			cname := c first toZ3Symbol.
			rname := c second toZ3Symbol.
			fs := c last.
			fsrs := fs collect: [ :f |
				| fname ftype |
				fname := f key.
				ftype := f value.
				{fname toZ3Symbol}, (ftype sort_reft: ds) ].
			fsrs := fsrs unzip: 3.
			fnames := fsrs first. sorts := fsrs second. refs := fsrs third.
			z3c := Z3 mk_constructor: Z3Context current
				_: cname
				_: rname
				_: fs size
				_: fnames
				_: sorts
				_: refs.
			"TODO: to_delete.append(ScopedConstructor(cs[j], ctx))"
			z3c ].
		clist := Z3 mk_constructor_list: Z3Context current
			_: cs size
			_: cs.
		"to_delete.append(ScopedConstructorList(clists[i], ctx))"
		clist ].
	out := Array new: num.
	Z3 mk_datatypes: Z3Context current
		_: num
		_: ((ds collect: #name) collect: #toZ3Symbol)
		_: out
		_: clists.
	
	drefs:= out collect: [ :dref |
		(1 to: dref numConstructors) do: [ :j |
			| cref cref_name cref_arity rref |
			cref := dref constructor: j-1.
			cref_name := cref name.
			cref_arity := cref arity.
			"cref_arity = 0 ifTrue: [ cref := cref value ]."
			dref at: cref_name put: cref.
			rref := dref recognizer: j-1.
			dref at: 'is_', cref_name put: rref.
			1 to: cref_arity do: [ :k |
				| aref |
				aref := dref accessor: j-1 idx: k-1.
				dref at: aref name put: aref ] ].
		dref ].
	^drefs

]

{ #category : #'instance creation' }
Z3Datatype class >> named: aString [
	^self basicNew
		ctx: Z3Context current;
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

{ #category : #accessing }
Z3Datatype >> ctx [
	^ ctx
]

{ #category : #accessing }
Z3Datatype >> ctx: anObject [
	ctx := anObject
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
