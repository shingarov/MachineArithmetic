Extension { #name : #SimpleZ3Test }

{ #category : #'*PLE-Tests' }
SimpleZ3Test >> testConstEEq [
	| p su |
	p := 'x' toInt === 42. "the special 'x=c' form"
	su := p constEEqOrNil.
	self assert: su key   equals: 'x' toInt.
	self assert: su value equals:  42 toInt
]

{ #category : #'*PLE-Tests' }
SimpleZ3Test >> testConstEEqNil [
	self assert: 1 toInt constEEqOrNil isNil
]

{ #category : #'*PLE-Tests' }
SimpleZ3Test >> testConstEEqNilLt [
	self assert: ('x' toInt < 0) constEEqOrNil isNil
]
