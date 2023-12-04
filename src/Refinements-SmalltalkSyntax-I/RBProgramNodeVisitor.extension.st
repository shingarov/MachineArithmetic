Extension { #name : #RBProgramNodeVisitor }

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBProgramNodeVisitor >> visitBoundArgumentNode: aBoundArgumentNode [
	^ self visitArgumentNode: aBoundArgumentNode 
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBProgramNodeVisitor >> visitExistentialQuantificationNode: anExistentialQuantificationNode [
	^ self visitQuantificationNode: anExistentialQuantificationNode
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBProgramNodeVisitor >> visitExistentiallyBoundVariableNode: anExistentiallyBoundVariableNode [
	^ self visitSortedArgumentNode: anExistentiallyBoundVariableNode 
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBProgramNodeVisitor >> visitHornNode: aHornNode [
	aHornNode arguments do: [ :node | self visitSequenceNode: node argSorts ].
	self visitBlockNode: aHornNode
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBProgramNodeVisitor >> visitHornVariableNode: aHornVariableNode [
	^ self visitBoundArgumentNode: aHornVariableNode
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBProgramNodeVisitor >> visitLambdaArgumentNode: aLambdaArgumentNode [
	^ self visitArgumentNode: aLambdaArgumentNode 
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBProgramNodeVisitor >> visitQuantificationNode: aQuantificationNode [
	aQuantificationNode arguments do: [ :node |
		self visitNode: node sort.
		node reft isNil ifFalse: [ self visitNode: node reft ] ].
	self visitBlockNode: aQuantificationNode.
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBProgramNodeVisitor >> visitSortedArgumentNode: aSortedArgumentNode [
	^ self visitBoundArgumentNode: aSortedArgumentNode 
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBProgramNodeVisitor >> visitUniversalQuantificationNode: anUniversalQuantificationNode [
	^ self visitQuantificationNode: anUniversalQuantificationNode
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBProgramNodeVisitor >> visitUniversallyBoundVariableNode: anUniversallyBoundVariableNode [
	^ self visitSortedArgumentNode: anUniversallyBoundVariableNode 
]
