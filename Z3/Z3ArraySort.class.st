Class {
	#name : #Z3ArraySort,
	#superclass : #Z3Sort,
	#category : #'Z3-Core'
}

{ #category : #inhabitation }
Z3ArraySort >> anyOne [
	| a solver element |
	a := self mkFreshConst: nil.
	solver := Z3Solver new.
	solver assert: ((a arraySelect: self domain anyOne) === self range anyOne).
	solver check.
	element := solver getModel eval: a completion: false.
	solver del.
	^element
	
]

{ #category : #'type theory' }
Z3ArraySort >> cast: value [
	^ self shouldImplement
]

{ #category : #'type theory' }
Z3ArraySort >> domain [
	^Z3 get_array_sort_domain: self ctx _: self
]

{ #category : #'type theory' }
Z3ArraySort >> nodeClass [
	self range isBoolSort ifTrue: [ 
		^ Z3Set
	].
	^ McCarthyArray
]

{ #category : #'type theory' }
Z3ArraySort >> range [
	^Z3 get_array_sort_range: self ctx _: self
]
