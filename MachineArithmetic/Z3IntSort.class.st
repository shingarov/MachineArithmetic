Class {
	#name : #Z3IntSort,
	#superclass : #Z3Sort,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'type theory' }
Z3IntSort >> nodeClass [
	^ Int

]

{ #category : #printing }
Z3IntSort >> printString [
	^ 'Z3Sort int'

]
