Extension { #name : #RBParser }

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBParser >> parseBoundVariableNode: x ofClass: c [
	| sortNode refinementNode |
	(currentToken isBinary and: [ currentToken value = '∈' ]) ifFalse: [self error]. self step.
	(currentToken isSpecial and: [ currentToken value = $( ])
		ifTrue: [ 
			self step.
			sortNode := self sequenceNodeClass new.
			(self parseStatements: false into: sortNode).
			(currentToken isSpecial and: [ currentToken value = $) ]) ifFalse: [self error].
			self step
		] ifFalse: [
			sortNode := currentToken.
			self step
		].
	(currentToken isSpecial and: [ currentToken value = $( ]) ifTrue: [
		self step.
		refinementNode := self sequenceNodeClass new.
		(self parseStatements: false into: refinementNode).
		(currentToken isSpecial and: [ currentToken value = $) ]) ifFalse: [self error]. self step.
	].
	^c named: x name sort: sortNode reft: refinementNode
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBParser >> parseVariableNodeBoundBy: token [
	| x nodeClass |
	x := self parseVariableNode.
	token value = $: ifTrue: [ ^x ]. ":x"
	
	token value = Character forall ifTrue: [nodeClass := RBUniversallyBoundVariableNode].
	token value = Character exists ifTrue: [nodeClass := RBExistentiallyBoundVariableNode].
	
	^self parseBoundVariableNode: x ofClass: nodeClass 
]
