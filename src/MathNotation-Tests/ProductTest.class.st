Class {
	#name : #ProductTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MathNotation-Tests'
}

{ #category : #tests }
ProductTest >> testArrayToProduct [
	self assert: #(a) toProduct first equals: #a
]

{ #category : #tests }
ProductTest >> testAssociative [
	| A B C |
	A := 'A' toSort.
	B := 'B' toSort.
	C := 'C' toSort.
	self assert: (A×B)×C equals: A×(B×C)
]

{ #category : #tests }
ProductTest >> testFirstDegree [
	| A |
	A := 'A' toSort.
	self assert: A ≅ A toProduct.
	self assert: A toProduct ≅ A.
]

{ #category : #tests }
ProductTest >> testLeftNeutral [
	| A |
	A := 'A' toSort.
	self assert: Product new × A equals: (Product with: A)
]

{ #category : #tests }
ProductTest >> testNullaryRelation [
	| domain r b |
	domain := Product new.
	r := domain mkRelationNamed: 'r'.
	b := r value.
	self assert: 'r' toBool == b
]

{ #category : #tests }
ProductTest >> testPrintEmptyString [
	self
		assert: Product new printString
		equals: '()'
]

{ #category : #tests }
ProductTest >> testPrintString [
	self
		assert: ('A' toSort × 'B' toSort) printString
		equals: '(A × B)'
]

{ #category : #tests }
ProductTest >> testRelation [
	| A a p pa |
	A := 'A' toSort.
	p := A toProduct mkRelationNamed: 'p'.
	a := A mkConst: 'a'.
	pa := p value: a.
	self assert: pa isBool.
	self assert: pa isApp.
	self assert: pa functorName equals: 'p'.
	self assert: pa args first equals: a.
	self assert: pa astToString equals: '(p a)'.
]

{ #category : #tests }
ProductTest >> testRightNeutral [
	| A |
	A := 'A' toSort.
	self assert: A toProduct × Product new equals: A toProduct
]
