Class {
	#name : #Z3UninterpretedSort,
	#superclass : #Z3Sort,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'type theory' }
Z3UninterpretedSort >> cast: x [ 
	x sort = self ifFalse: [ self error ].
	^x
]

{ #category : #'type theory' }
Z3UninterpretedSort >> nodeClass [
	^ Uninterpreted

]
