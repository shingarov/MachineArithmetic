Extension { #name : #String }

{ #category : #'*MachineArithmetic' }
String >> asBitVector: xlen [
	^BitVector sym: self length: xlen
]

{ #category : #'*MachineArithmetic' }
String >> functionFrom: domainSorts to: rangeSort [
	^self asZ3Symbol mkFuncFrom: domainSorts to: rangeSort
]
