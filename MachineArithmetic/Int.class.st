"
Fixed-point machine-arithmetic integer (i.e., integer mod word size).
"
Class {
	#name : #Int,
	#superclass : #AST,
	#category : #'MachineArithmetic-Bits'
}

{ #category : #private }
Int class >> fromExternalID: anExternalID [ 
	| op |
	op := self opOf: anExternalID.
	op = 'BVV' ifTrue: [ ^IntValue var: anExternalID ].
	op = 'BVS' ifTrue: [ ^IntSymbol  var: anExternalID ].
	^Int var: anExternalID 
]

{ #category : #private }
Int class >> pythonClassName [ 
	^'BV'
]

{ #category : #arithmetic }
Int >> + aNumber [
	| ref |
	ref := self ref, ' + ', aNumber ref.
	^P compute: ref

]

{ #category : #arithmetic }
Int >> , aNumber [
	| ref |
	ref := 'angr.state_plugins.solver.SimSolver().simplify(claripy.Concat( ', self ref, ' , ', aNumber ref, '))'.
	^P compute: ref
]

{ #category : #arithmetic }
Int >> - aNumber [
	| ref |
	ref := self ref, ' - ', aNumber ref.
	^P compute: ref

]

{ #category : #arithmetic }
Int >> << aNumber [ 
	| ref |
	ref := self ref, ' << ', aNumber ref.
	^P compute: ref

]

{ #category : #access }
Int >> length [
	^P eval: self ref, '.size()'
]

{ #category : #arithmetic }
Int >> reversed [
	"Answer the endian-reversed myself"
	| ref |
	ref := self ref, '.reversed'.
	^P compute: ref

]
