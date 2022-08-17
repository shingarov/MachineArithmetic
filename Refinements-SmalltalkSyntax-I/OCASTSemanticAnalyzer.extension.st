Extension { #name : #OCASTSemanticAnalyzer }

{ #category : #'*Refinements-SmalltalkSyntax-I' }
OCASTSemanticAnalyzer >> visitHornNode: aBlockNode [
	aBlockNode arguments do: [ :node |
		self visitNode: node domain ].
	self visitBlockNode: aBlockNode.
]
