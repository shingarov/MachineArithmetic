Class {
	#name : #ProductTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Tests'
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
ProductTest >> testRightNeutral [
	| A |
	A := 'A' toSort.
	self assert: A toProduct × Product new equals: A toProduct
]
