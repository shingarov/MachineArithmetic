Class {
	#name : #Z3RealSort,
	#superclass : #Z3Sort,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'type theory' }
Z3RealSort >> nodeClass [
	^ Real

]

{ #category : #printing }
Z3RealSort >> printString [
	^String with: Character reals
]
