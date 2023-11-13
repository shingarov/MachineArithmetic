Class {
	#name : #Z3UninterpretedSort,
	#superclass : #Z3Sort,
	#category : #'Z3-Core'
}

{ #category : #'type theory' }
Z3UninterpretedSort >> cast: value [
	value sort = self ifFalse: [ self error ].
	^value
]

{ #category : #'type theory' }
Z3UninterpretedSort >> nodeClass [
	^ Uninterpreted

]
