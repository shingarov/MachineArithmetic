Extension { #name : #RBParserTest }

{ #category : #'*Refinements-SmalltalkSyntax-Tests' }
RBParserTest >> testHoleNode [
	| hn |
	hn := self parserClass parseExpression: ' [ ⋆κ(#placeholderForDomain) | κ value: 1 ]'.
	self assert: (hn isKindOf: HornBlockNode).
	self assert: hn arguments first name equals: 'κ'.
	self assert: hn arguments first argSorts statements first value equals: #placeholderForDomain.

]

{ #category : #'*Refinements-SmalltalkSyntax-Tests' }
RBParserTest >> testLambdaNode [
	self assert: ((RBParser parseMethod:  'f
			^[ :x | x > 0 ]') isKindOf: RBMethodNode)

]

{ #category : #'*Refinements-SmalltalkSyntax-Tests' }
RBParserTest >> testMultivariateLambda [
	self assert: ((RBParser parseMethod:  'f
			^[ :x :y :z | x > 0 ]') isKindOf: RBMethodNode)

]

{ #category : #'*Refinements-SmalltalkSyntax-Tests' }
RBParserTest >> testQuantificationNode [
	| qbn |
	qbn := self parserClass parseExpression: ' [ ∀x ∈ (#placeholderForSort) | x > 0 ]'.
	self assert: (qbn isKindOf: UniversalQuantificationNode).
	self assert: qbn arguments first sort statements first value equals: #placeholderForSort.
	self assert: qbn arguments first reft isNil

]

{ #category : #'*Refinements-SmalltalkSyntax-Tests' }
RBParserTest >> testQuantificationNodeE [
	| qbn |
	qbn := self parserClass parseExpression: ' [ ∃x ∈ (#placeholderForSort) | x > 0 ]'.
	self assert: (qbn isKindOf: ExistentialQuantificationNode).
	self assert: qbn arguments first sort statements first value equals: #placeholderForSort.
	self assert: qbn arguments first reft isNil

]

{ #category : #'*Refinements-SmalltalkSyntax-Tests' }
RBParserTest >> testQuantificationShortForm [
	| qbn |
	qbn := self parserClass parseExpression: ' [ ∀x ∈ Srt | x > 0 ]'.
	self assert: (qbn isKindOf: UniversalQuantificationNode).
	self assert: qbn arguments first sort name equals: 'Srt'.
	self assert: qbn arguments first reft isNil

]

{ #category : #'*Refinements-SmalltalkSyntax-Tests' }
RBParserTest >> testRefinedQuantificationNode [
	| qbn |
	qbn := self parserClass parseExpression: ' [ ∀x ∈ (#placeholderForSort) [x > 10] | x > 0 ]'.
	self assert: (qbn isKindOf: UniversalQuantificationNode).
	self assert: qbn arguments first sort statements first value equals: #placeholderForSort.
	self assert: (qbn arguments first isKindOf: UniversallyBoundVariableNode).
	self assert: (qbn arguments first reft isKindOf: RBBlockNode).

]
