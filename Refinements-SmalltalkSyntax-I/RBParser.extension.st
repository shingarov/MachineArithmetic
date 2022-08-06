Extension { #name : #RBParser }

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBParser >> parseQuantificationRefinement [
	^(self currentToken isSpecial and: [ self currentToken value = $[ ])
		ifTrue: [ self parseBlock ]
		ifFalse: [ nil ]
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBParser >> parseQuantificationSort [
	| sortNode |
	(self currentToken isSpecial and: [ self currentToken value = $( ])
		ifTrue: [ 
			self step.
			sortNode := self sequenceNodeClass new.
			(self parseStatements: false into: sortNode).
			(self currentToken isSpecial and: [ self currentToken value = $) ]) ifFalse: [self error].
			self step
		] ifFalse: [
			sortNode := RBVariableNode named: self currentToken value start: self currentToken start.
			self step
		].
	^sortNode
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBParser >> parseVariableNodeBoundBy: token [
	| x nodeClass |
	x := self parseVariableNode.
	nodeClass := BoundArgumentNode concreteClassFor: token value.
	^nodeClass parseBoundVariableNode: x parser: self
]
