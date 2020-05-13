Class {
	#name : #Z3Context,
	#superclass : #FFIIdentityObject,
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

{ #category : #'global context' }
Z3Context class >> delCurrent [
	| current |
	current := self current.
	current del.
	current == Global ifTrue: [ Global := nil ]
]

{ #category : #'instance creation' }
Z3Context class >> from: aZ3Config [
	^LibZ3 uniqueInstance mkContext: aZ3Config 
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
	LibZ3 uniqueInstance delContext: self
]

{ #category : #'as yet unclassified' }
Z3Context >> mkBoolVar: name [
	| ty |
	ty := Z3Sort boolSortOn: self.
	^self mkVar: name ofSort: ty
]

{ #category : #'as yet unclassified' }
Z3Context >> mkFalse [
	"Create an AST node representing false."
	^AST wrap: (LibZ3 uniqueInstance mkFalse: self) in: self
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
	"Create an AST node representing false."
	^AST wrap: (LibZ3 uniqueInstance mkTrue: self) in: self
]

{ #category : #'as yet unclassified' }
Z3Context >> mkVar: name ofSort: ty [
	| sym |
	sym := self mkSymbol: name.
	^AST mkConst: sym ofSort: ty
]

{ #category : #'as yet unclassified' }
Z3Context >> parseSmtlib2String: aString [
	^(LibZ3 uniqueInstance parseSmtlib2: self string: aString
		unsigned: 0 z3symbols: nil z3sorts: nil unsigned: 0 z3symbols: nil funcDecls: nil) ctx: self
]
