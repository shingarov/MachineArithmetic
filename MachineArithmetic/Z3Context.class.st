Class {
	#name : #Z3Context,
	#superclass : #Z3Object,
	#instVars : [
		'asts'
	],
	#classVars : [
		'Global'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #'global context' }
Z3Context class >> createGlobalContext [
	Global := self fromDefault
]

{ #category : #'global context' }
Z3Context class >> current [
	"TODO: local contexts"
	^self global
]

{ #category : #'instance creation' }
Z3Context class >> from: aZ3Config [
	^Z3 mk_context: aZ3Config 

]

{ #category : #'instance creation' }
Z3Context class >> fromDefault [
	^self from: Z3Config default
]

{ #category : #'global context' }
Z3Context class >> global [
	Global isNil ifTrue: [ self createGlobalContext ].
	^Global
]

{ #category : #'system info' }
Z3Context class >> z3fullVersion [
	^LibZ3 getFullVersion 
]

{ #category : #'system info' }
Z3Context class >> z3version [
	^LibZ3 getVersion
]

{ #category : #'system info' }
Z3Context class >> z3versionString [
	^LibZ3 getVersionString
]

{ #category : #'as yet unclassified' }
Z3Context >> del [
	"In case #del is sent to current global context, we have to flush it first 
	 before we `z3_del_context()` to make sure no subsequent code will use it. 

	 This is not fool-proof as there still may be instances that uses it, but still 
	 this helps to stabilize tests. We need ref-counting..."

	Global == self ifTrue:[Global := nil].
	Z3 del_context: self.
	self poison

]

{ #category : #initialization }
Z3Context >> initializeWithAddress: anExternalAddress [
	super initializeWithAddress: anExternalAddress.
	asts := WeakValueDictionary new.

]

{ #category : #'private - AST management' }
Z3Context >> internAST: class address: address [
	| ast |

	ast := asts at: address asInteger 
				ifAbsentPut: [ class basicNew initializeWithAddress: address context: self ].

	self assert: ast class == class.
	self assert: ast asInteger = address asInteger.
	self assert: ast ctx == self.

	^ ast

]

{ #category : #'private - AST management' }
Z3Context >> internAST: class address: address kind: kind sort: sort [
	| ast |

	ast := asts at: address asInteger 
				ifAbsentPut: [ class basicNew initializeWithAddress: address context: self kind: kind sort: sort ].

	self assert: ast class == class.
	self assert: ast asInteger = address asInteger.
	self assert: ast ctx == self.
	self assert: ast kind == kind.
	self assert: ast sort == sort.

	^ ast

]

{ #category : #'as yet unclassified' }
Z3Context >> mkBoolVar: name [
	| ty |
	ty := Z3Sort boolSortOn: self.
	^self mkVar: name ofSort: ty
]

{ #category : #'as yet unclassified' }
Z3Context >> mkDistinct: astArray [
	| externalArgs |
	externalArgs := self externalArrayFrom:  astArray.
	^Z3AST
		wrap: (LibZ3 uniqueInstance mkDistinct: self numArgs: astArray size args: externalArgs)
		in: self

]

{ #category : #'as yet unclassified' }
Z3Context >> mkFalse [
	"Create an AST node representing false."
	^Z3 mk_false: self

]

{ #category : #'as yet unclassified' }
Z3Context >> mkInt: anInteger [
	"Create a Z3 integer node using a C int."
	| ty |
	ty := Z3Sort intSortOn: self.
	^ty mkInt: anInteger 
]

{ #category : #'as yet unclassified' }
Z3Context >> mkIntVar: name [
	| ty |
	ty := Z3Sort intSortOn: self.
	^self mkVar: name ofSort: ty
]

{ #category : #'as yet unclassified' }
Z3Context >> mkSymbol: stringOrInteger [
	^Z3Symbol from: stringOrInteger on: self
]

{ #category : #'as yet unclassified' }
Z3Context >> mkTrue [
	"Create an AST node representing true."
	^Z3 mk_true: self

]

{ #category : #'as yet unclassified' }
Z3Context >> mkVar: name ofSort: ty [
	| sym |
	sym := self mkSymbol: name.
	^Z3AST mkConst: sym ofSort: ty

]

{ #category : #'as yet unclassified' }
Z3Context >> parseSmtlib2String: aString [
	^(LibZ3 uniqueInstance parseSmtlib2: self string: aString
		unsigned: 0 z3symbols: nil z3sorts: nil unsigned: 0 z3symbols: nil funcDecls: nil) ctx: self
]
