Class {
	#name : #B,
	#superclass : #AorB,
	#category : #'MachineArithmetic-Syntax-Tests'
}

{ #category : #syntax }
B class >> parser [
	^Integer parser brackets
	==> [ :x | self with: x ]
]
