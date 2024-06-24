Extension { #name : #RBParserTest }

{ #category : #'*MathNotation-Tests' }
RBParserTest >> testSectioningCollect [
	self
		assert: (#(1 2 3) collect: 100+□)
		equals: #(101 102 103)
]

{ #category : #'*MathNotation-Tests' }
RBParserTest >> testSectioningL [
	self
		assert: (□+4 value: 3)
		equals: 7
]

{ #category : #'*MathNotation-Tests' }
RBParserTest >> testSectioningLR [
	self
		assert: (□+□ value: 3 value: 4)
		equals: 7
]

{ #category : #'*MathNotation-Tests' }
RBParserTest >> testSectioningR [
	self
		assert: (3+□ value: 4)
		equals: 7
]
