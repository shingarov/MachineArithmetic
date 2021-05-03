Class {
	#name : #Z3QuantifierNode,
	#superclass : #Bool,
	#category : #'MachineArithmetic-Core'
}

{ #category : #printing }
Z3QuantifierNode >> printString [
	^ self astToString

]
