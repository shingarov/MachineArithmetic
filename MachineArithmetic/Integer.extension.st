Extension { #name : #Integer }

{ #category : #'*MachineArithmetic' }
Integer >> /// length [
	^self toBitVector: length
]

{ #category : #'*MachineArithmetic' }
Integer >> ones [
	^-1 toBitVector: self
]

{ #category : #'*MachineArithmetic' }
Integer >> toBitVector: length [
	^BitVector value: self length: length
]

{ #category : #'*MachineArithmetic' }
Integer >> toInt [
	^Int value: self
]

{ #category : #'*MachineArithmetic' }
Integer >> toReal [
	^Real value: self

	"Created: / 03-12-2021 / 14:25:17 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #'*MachineArithmetic' }
Integer >> toZ3Sort: s [ 
	s == Int sort ifFalse: [ self error: 'Don''t know how to convert Integer to ', s printString ].
	^self toInt
]

{ #category : #'*MachineArithmetic' }
Integer >> zeros [
	^0 toBitVector: self
]
