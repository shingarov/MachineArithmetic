Extension { #name : #OCASTSemanticAnalyzer }

{ #category : #'*Refinements-SmalltalkSyntax-I' }
OCASTSemanticAnalyzer >> visitHornNode: aBlockNode [
	aBlockNode arguments do: [ :node |
		self visitNode: node argSorts ].
	self visitBlockNode: aBlockNode.
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
OCASTSemanticAnalyzer >> visitQuantificationNode: aBlockNode [
	aBlockNode arguments do: [ :node |
		self visitNode: node sort.
		node reft isNil ifFalse: [ self visitNode: node reft ] ].
	self visitBlockNode: aBlockNode.
]
