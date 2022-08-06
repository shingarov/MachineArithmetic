Extension { #name : #RBParserTest }

{ #category : #'*Refinements-SmalltalkSyntax-Tests' }
RBParserTest >> testMultivariateLambda [
	self assert: ((RBParser parseMethod:  'f
			^[ :x :y :z | x > 0 ]') isKindOf: RBMethodNode)

]

{ #category : #'*Refinements-SmalltalkSyntax-Tests' }
RBParserTest >> testQuantificationNode [
	| qbn |
	qbn := self parserClass parseExpression: ' [ ∀x ∈ (#placeholderForSort) | x > 0 ]'.
	self assert: qbn arguments first sort statements first value equals: #placeholderForSort.
	self assert: qbn arguments first reft isNil

]

{ #category : #'*Refinements-SmalltalkSyntax-Tests' }
RBParserTest >> testRefinedQuantificationNode [
	| qbn |
	qbn := self parserClass parseExpression: ' [ ∀x ∈ (#placeholderForSort) (x > 10) | x > 0 ]'.
	self assert: qbn arguments first sort statements first value equals: #placeholderForSort.
	self assert: (qbn arguments first isKindOf: RBUniversallyBoundVariableNode) 

]
