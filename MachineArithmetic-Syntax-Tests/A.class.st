Class {
	#name : #A,
	#superclass : #AorB,
	#category : #'MachineArithmetic-Syntax-Tests'
}

{ #category : #syntax }
A class >> parser [
	^Integer parser parens
	==> [ :x | self with: x ]
]
