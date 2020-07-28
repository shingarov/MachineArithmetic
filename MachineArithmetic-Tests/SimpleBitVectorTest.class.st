Class {
	#name : #SimpleBitVectorTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests'
}

{ #category : #tests }
SimpleBitVectorTest >> testAlreadyBitvector [
	| x xx |
	x := 42 asBitVector: 32.
	xx := x asBitVector: 32.
	self assert: x==xx
]

{ #category : #tests }
SimpleBitVectorTest >> testConcatenation [
	| a b ab |
	a := 16rA asBitVector: 4.
	b := 16rB asBitVector: 4.
	ab := a, b.
	self assert: ab isBitVector.
	self deny: ab isNumeral.
	ab := ab simplify.
	self assert: ab isNumeral.
	self assert: ab value equals: 16rAB
]

{ #category : #tests }
SimpleBitVectorTest >> testCreate42 [
	| bv |
	bv := 42 asBitVector: 32.
	self assert: bv isBitVector 
]

{ #category : #tests }
SimpleBitVectorTest >> testCreateX [
	| bv |
	bv := 'x' asBitVector: 32.
	self assert: bv isBitVector 
]

{ #category : #tests }
SimpleBitVectorTest >> testIntNotBV [
	| i |
	i := 42 toInt.
	self deny: i isBitVector 
]

{ #category : #tests }
SimpleBitVectorTest >> testIntNotBV2 [
	| i |
	i := Int var: 'x'.
	self deny: i isBitVector 
]

{ #category : #tests }
SimpleBitVectorTest >> testLengthMismatch [
	| x |
	x := 42 asBitVector: 32.
	self should: [ x asBitVector: 64 ] raise: Error
]

{ #category : #tests }
SimpleBitVectorTest >> testProveStrengthReductionBV [
	| x thm solver |
	x := 'x' asBitVector: 32. "Z3Sorts are simple-types,
		so we can't quantify over the bitvector size.
		For that, we would need the type of bitvector
		dependent on symbolic size."
	thm := x+x eq: 2*x.
	solver := Solver new.
	solver proveValid: thm.
	solver del
]

{ #category : #tests }
SimpleBitVectorTest >> testProveStrengthReductionBV3 [
	| x thm solver |
	"A slightly more-complex expression than in the previous test."
	x := 'x' asBitVector: 32.
	thm := x+x+x eq: x*3.
	solver := Solver new.
	solver proveValid: thm.
	solver del
]

{ #category : #tests }
SimpleBitVectorTest >> testProveStrengthReductionInt [
	| x thm solver |
	x := Int var: 'x'.
	thm := x+x eq: x*2.
	solver := Solver new.
	solver proveValid: thm.
	solver del
]

{ #category : #tests }
SimpleBitVectorTest >> testRepeat [
	| a aaaaa |
	a := 16rAB asBitVector: 8.
	self assert: a length equals: 8.
	self assert: a isNumeral.
	aaaaa := a repeat: 5.
	self assert: aaaaa isBitVector.
	self assert: aaaaa length equals: 5*8.
	self assert: aaaaa kindClass equals: ASTKindAPP.
	self deny: aaaaa isNumeral.
	aaaaa := aaaaa simplify.
	self assert: aaaaa kindClass equals: ASTKindNUMERAL.
	self assert: aaaaa isNumeral.
	self assert: aaaaa value equals: 16rABABABABAB.
]

{ #category : #tests }
SimpleBitVectorTest >> testSlice [
	| x hiHalf loHalf mid |
	x := 16r12345678 asBitVector: 32.

	loHalf := x copyFrom: 15 to: 0.
	self deny: loHalf isNumeral.
	loHalf := loHalf simplify.
	self assert: loHalf isNumeral.
	self assert: loHalf value equals: 16r5678.
	
	hiHalf := x copyFrom: 31 to: 16.
	self deny: hiHalf isNumeral.
	hiHalf := hiHalf simplify.
	self assert: hiHalf isNumeral.
	self assert: hiHalf value equals: 16r1234.

	mid := x copyFrom: 19 to: 12.
	self deny: mid isNumeral.
	self assert: mid length equals: 8.
	mid := mid simplify.
	self assert: mid isNumeral.
	self assert: mid value equals: 16r45.

]

{ #category : #tests }
SimpleBitVectorTest >> testSubstituteBV [
	| x xPlus1 five from to r |
	x := 'x' asBitVector: 32.
	xPlus1 := x + 1.
	five := 5 asBitVector: 32.
	
	from := Array with: x.
	to := Array with: five.
	
	r := xPlus1 substituteAll: from with: to.
	r astToString.
	self assert: r term arity equals: 2.
	r := r simplify.
	self assert: r equals: 6
]

{ #category : #tests }
SimpleBitVectorTest >> testSubstituteExtra [
	| x y xPlus1 five from to r |
	x := 'x' asBitVector: 32.
	xPlus1 := x + 1.
	five := 5 asBitVector: 32.
	y := 'y' asBitVector: 32.
	
	from := Array with: x with: y.
	to := Array with: five with: five.
	
	r := xPlus1 substituteAll: from with: to.
	r astToString.
	self assert: r term arity equals: 2.
	r := r simplify.
	self assert: r equals: 6
]
