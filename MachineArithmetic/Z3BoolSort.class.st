Class {
	#name : #Z3BoolSort,
	#superclass : #Z3Sort,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'type theory' }
Z3BoolSort >> nodeClass [
	^ Bool

]

{ #category : #printing }
Z3BoolSort >> printString [
	^ 'Z3Sort bool'

]
