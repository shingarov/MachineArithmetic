"
An Int in which all bits are concretely known.
"
Class {
	#name : #IntValue,
	#superclass : #Int,
	#category : #'MachineArithmetic-Bits'
}

{ #category : #'instance creation' }
IntValue class >> value: x length: l [
	| var construct |
	construct := 'claripy.BVV(', x printString, ',', l printString, ')'.
	var := P evalAndAssign: construct.
	^self var: var
]

{ #category : #converting }
IntValue >> adaptToNumber: anInteger andSend: selector [
	^self perform: selector with: anInteger 
]

{ #category : #access }
IntValue >> asInteger [ 
	^self value
]

{ #category : #testing }
IntValue >> isLeaf [ 
	^true
]

{ #category : #access }
IntValue >> value [
	^P eval: self ref, '.args[0]'
]
