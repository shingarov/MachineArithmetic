Class {
	#name : #Z3ArraySort,
	#superclass : #Z3Sort,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'type theory' }
Z3ArraySort >> domain [
	^Z3 get_array_sort_domain: self ctx _: self
]

{ #category : #'type theory' }
Z3ArraySort >> nodeClass [
	^ McCarthyArray

]

{ #category : #'type theory' }
Z3ArraySort >> range [
	^Z3 get_array_sort_range: self ctx _: self
]
