"
I provide a level of API to Z3 Datatypes slightly higher than the C API.
My structure is similar to the Python Z3Datatype, but I dont attempt to
""be dynamic"".  I am intended to bridge between Z3DatatypeSort (which
follows the C API) and DataDecl in Fixpoint.  Clients should preferably
NOT use this intermediate-level API.

Notes on Implementation:

is- doesn't get correctly stored in the ??? anyway.
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
			fnames := fsrs collect:#first. sorts := fsrs collect:#second. refs := fsrs collect:#third.
			constructors add: (Z3Constructor
				name: cname
				recognizer: rname
				fields: (fnames with: sorts collect:[:n :s | n -> s])
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

{ #category : #'SMT interface' }
MonomorphizedDataDecl >> addReferencedDatatypesTo: anOrderedCollection [
	(anOrderedCollection includes: self) ifFalse: [
		anOrderedCollection add: self.
		self constructors do: [ :con |
			con third doAssociations: [ :fldName :fldType | fldType isAST ifFalse: [fldType addReferencedDatatypesTo: anOrderedCollection ] ] ] ]
]

{ #category : #'recursive adt' }
MonomorphizedDataDecl >> andAllReferencedDatatypes [
	"self will always be the first"
	| all |
	all := OrderedCollection new.
	self addReferencedDatatypesTo: all.
	^all
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
	^(self class createDatatypes: self andAllReferencedDatatypes) first
]

{ #category : #'SMT interface' }
MonomorphizedDataDecl >> declare: constructorName accessors: assocs [ 
	self
		declareCore: constructorName
		recognizer: 'is-', constructorName
		accessors: assocs
	"
	Caveat Programmator:
	
	The function name in the FuncDecl will NOT be is-c,
	but the special marker OP_DT_IS ('is', see comment before
	enum Z3_decl_kind in z3_api.h, and get_constructor_is()
	definition in z3/src/ast/datatype_decl_plugin.cpp.
	
	NB: The actual tsSym in the TheorySymbol is is$c,
	while is-c is the tsRaw ('serialized SMTLIB2 name').
	In Smalltalk we can't use that because the Z3 C API
	lacks SMTLIB2's parametrized datatypes (par (T0) ...)
	"
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
