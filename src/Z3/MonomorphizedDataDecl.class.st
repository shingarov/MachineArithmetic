"
I provide a level of API to Z3 Datatypes slightly higher than the C API.
My structure is similar to the Python Z3Datatype, but I dont attempt to
""be dynamic"".  I am intended to bridge between Z3DatatypeSort (which
follows the C API) and DataDecl in Fixpoint.  Clients should preferably
NOT use this intermediate-level API.
"
Class {
	#name : #MonomorphizedDataDecl,
	#superclass : #Object,
	#instVars : [
		'name',
		'constructors'
	],
	#category : #'Z3-Core'
}

{ #category : #'SMT interface' }
MonomorphizedDataDecl class >> createDatatypes: ds [
	| clists constructors z3sorts |
	constructors := OrderedCollection new.
	clists := OrderedCollection new.
	clists := ds collect: [ :d |
		| cs clist |
		cs := d constructors collect: [ :c |
			| cname rname fs fsrs  fnames sorts refs |
			cname := c first toZ3Symbol.
			rname := c second toZ3Symbol.
			fs := c last.
			fsrs := fs collect: [ :f |
				| fname ftype |
				fname := f key.
				ftype := f value.
				{fname toZ3Symbol}, (ftype sort_index: ds) ].
			fsrs := fsrs unzip: 3.
			fnames := fsrs first. sorts := fsrs second. refs := fsrs third.
			constructors add: (Z3Constructor
				name: cname
				recognizer: rname
				fields: (fnames zip: sorts)
				referencing: refs) "and this returns the constructor from the block"
			].
		clist := Z3ConstructorList withAll: cs.
		clists add: clist
	].
	z3sorts := Z3DatatypeSort names: (ds collect: #name) constructorLists: clists.
	clists do: #delete.
	constructors do: #delete.
	^z3sorts
]

{ #category : #'instance creation' }
MonomorphizedDataDecl class >> named: aString [
	^self basicNew
		name: aString;
		constructors: OrderedCollection new;
		yourself
]

{ #category : #accessing }
MonomorphizedDataDecl >> constructors [
	^ constructors
]

{ #category : #accessing }
MonomorphizedDataDecl >> constructors: anObject [
	constructors := anObject
]

{ #category : #'SMT interface' }
MonomorphizedDataDecl >> create [
	"Create a Z3 datatype based on the constructors declared via #declare:.                                    
	 This is a convenience wrapper around #createDatatypes:.
	 The latter must be used to define mutually recursive datatypes."
	^(self class createDatatypes: {self}) first
]

{ #category : #'SMT interface' }
MonomorphizedDataDecl >> declare: constructorName accessors: assocs [ 
	self
		declareCore: constructorName recognizer: 'Doesnt_work_anyway_', constructorName
		accessors: assocs
]

{ #category : #'SMT interface' }
MonomorphizedDataDecl >> declareCore: constructorName recognizer: rec_name accessors: assocs [ 
	constructors addLast: { constructorName . rec_name . assocs }
]

{ #category : #accessing }
MonomorphizedDataDecl >> name [
	^ name
]

{ #category : #accessing }
MonomorphizedDataDecl >> name: anObject [
	name := anObject
]

{ #category : #printing }
MonomorphizedDataDecl >> printOn: aStream [
	aStream nextPutAll: 'Datatype '.
	aStream nextPutAll: self name
]

{ #category : #'recursive adt' }
MonomorphizedDataDecl >> sort_index: knownDatatypes [
	(knownDatatypes occurrencesOf: self) = 1 ifFalse: [ self error: 'One and only one occurrence of each datatype is expected' ].
	^{nil . (knownDatatypes indexOf: self) - 1}
]
