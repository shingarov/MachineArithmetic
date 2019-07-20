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
	^self construct: 'claripy.BVV(', x printString, ',', l printString, ')'
]

{ #category : #converting }
IntValue >> adaptToNumber: anInteger andSend: selector [
	^self perform: selector with: anInteger 
]

{ #category : #access }
IntValue >> asInteger [ 
	^self value
]

{ #category : #substitution }
IntValue >> inEnvironment: aDictionary [
	^self
]

{ #category : #testing }
IntValue >> isLeaf [ 
	^true
]

{ #category : #GT }
IntValue >> printForRegisterInspector [
	^'0x', (self value printStringBase: 16)
]

{ #category : #access }
IntValue >> signedValue [
	^P eval: 'claripy.bv.BVV( ', self ref, '.args[0], ', self ref, '.size() ).signed'
]

{ #category : #access }
IntValue >> value [
	^P eval: self ref, '.args[0]'
]
