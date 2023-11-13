Extension { #name : #String }

{ #category : #'*Z3' }
String >> /// length [
	^self toBitVector: length

]

{ #category : #'*Z3' }
String >> functionFrom: domainSorts to: rangeSort [
	^self toZ3Symbol mkFuncFrom: domainSorts to: rangeSort
]

{ #category : #'*Z3' }
String >> predicateOver: domain [
	^self toZ3Symbol mkPredicateOver: domain
]

{ #category : #'*Z3' }
String >> recursiveFunctionFrom: domainSorts to: rangeSort [
	^self toZ3Symbol mkRecFuncFrom: domainSorts to: rangeSort
]

{ #category : #'*Z3' }
String >> toBitVector: xlen [
	^BitVector sym: self length: xlen
]

{ #category : #'*Z3' }
String >> toBool [
	^Bool var: self
]

{ #category : #'*Z3' }
String >> toDatatype: t [
	^t mkConst: self
]

{ #category : #'*Z3' }
String >> toInt [
	^Int const: self
]

{ #category : #'*Z3' }
String >> toReal [
	^Real const: self

	"Created: / 03-12-2021 / 14:22:08 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #'*Z3' }
String >> toSort [
	^Z3Sort uninterpretedSortNamed: self
]
