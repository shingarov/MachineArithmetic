Extension { #name : #RBParser }

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBParser >> parseVariableNodeBoundBy: token [
	| x nodeClass |
	x := self parseVariableNode.
	nodeClass := BoundArgumentNode concreteClassFor: token value.
	^nodeClass parseBoundVariableNode: x parser: self
]
