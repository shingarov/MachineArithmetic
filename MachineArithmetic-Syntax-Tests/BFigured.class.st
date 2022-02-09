Class {
	#name : #BFigured,
	#superclass : #B,
	#category : #'MachineArithmetic-Syntax-Tests'
}

{ #category : #syntax }
BFigured class >> parser [
	^Integer parser braces
	==> [ :x | self with: x ]
]
