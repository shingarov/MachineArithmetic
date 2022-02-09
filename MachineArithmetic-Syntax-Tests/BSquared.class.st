Class {
	#name : #BSquared,
	#superclass : #B,
	#category : #'MachineArithmetic-Syntax-Tests'
}

{ #category : #syntax }
BSquared class >> parser [
	^Integer parser brackets
	==> [ :x | self with: x ]
]
