Extension { #name : #Integer }

{ #category : #'*Z3' }
Integer >> /// length [
	^self toBitVector: length
]

{ #category : #'*Z3' }
Integer >> ones [
	^-1 toBitVector: self
]

{ #category : #'*Z3' }
Integer >> toBitVector: length [
	^BitVector value: self length: length
]

{ #category : #'*Z3' }
Integer >> toInt [
	^Int value: self
]

{ #category : #'*Z3' }
Integer >> toReal [
	^Real value: self

	"Created: / 03-12-2021 / 14:25:17 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #'*Z3' }
Integer >> toZ3Sort: s [ 
	s == Int sort ifFalse: [ self error: 'Don''t know how to convert Integer to ', s printString ].
	^self toInt
]

{ #category : #'*Z3' }
Integer >> zeros [
	^0 toBitVector: self
]
