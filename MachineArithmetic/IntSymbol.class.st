"
An Int known to be given to be a certain cosa, X.
"
Class {
	#name : #IntSymbol,
	#superclass : #Int,
	#category : #'MachineArithmetic-Bits'
}

{ #category : #'instance creation' }
IntSymbol class >> sym: sym length: l [
	| var construct |
	construct := 'claripy.BVS(', sym printString, ',', l printString, ', explicit_name=True)'.
	var := P evalAndAssign: construct.
	^self var: var
]

{ #category : #testing }
IntSymbol >> isLeaf [ 
	^true
]

{ #category : #access }
IntSymbol >> sym [
	^P eval: self ref, '.args[0]'
]
