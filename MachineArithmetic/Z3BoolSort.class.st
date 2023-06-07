Class {
	#name : #Z3BoolSort,
	#superclass : #Z3Sort,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'type theory' }
Z3BoolSort >> cast: val [
	^val toBool
]

{ #category : #testing }
Z3BoolSort >> isBoolSort [
	^ true
]

{ #category : #'type theory' }
Z3BoolSort >> nodeClass [
	^ Bool

]
