Class {
	#name : #Z3Datatype,
	#superclass : #Object,
	#instVars : [
		'name',
		'ctx',
		'constructors'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #'as yet unclassified' }
Z3Datatype class >> createDatatypes: ds [
	| num names out clists toDelete |
	toDelete := OrderedCollection new.
	num := ds size.
	names := ds collect: [ :d |
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
		self halt.
		clist := Z3 mk_constructor_list: Z3Context current
			_: cs size
			_: cs.
	
		
		
		 ].
	
	self shouldBeImplemented.
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

	self shouldBeImplemented.
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
