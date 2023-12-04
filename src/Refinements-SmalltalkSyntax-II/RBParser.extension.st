Extension { #name : #RBParser }

{ #category : #'*Refinements-SmalltalkSyntax-II' }
RBParser >> parseBlock [
	| position node |
	position := currentToken start.
	self step.
	node := self blockNodeClass new. 
	node := self parseBlockArgsInto: node.
	self addCommentsTo: node.		
	node left: position.
	node body: self sequenceNodeClass new.
	(self parseStatements: false into: node body).
	
	(currentToken isSpecial and: [currentToken value = $]])
		ifFalse: [ self addParserError: ''']'' expected' to: node body.
			^ node].
	node right: currentToken start.
	self step.
	^node
]

{ #category : #'*Refinements-SmalltalkSyntax-II' }
RBParser >> parseBlockArgsInto: node [ 
	| verticalBar args colons quantifier |
	args := OrderedCollection new: 2.
	colons := OrderedCollection new: 2.
	verticalBar := false.
	[currentToken startsBlockArg] whileTrue: 
			[quantifier := currentToken.
			colons add: currentToken start.
			self step.	":"
			verticalBar := true.
			args add: (self parseVariableNodeBoundBy: quantifier) ].
	verticalBar 
		ifTrue: 
			[currentToken isBinary 
				ifTrue: 
					[node bar: currentToken start.
					currentToken value = #| 
						ifTrue: [self step]
						ifFalse: 
							[currentToken value = #'||' 
								ifTrue: 
									["Hack the current token to be the start 
									of temps bar"

									currentToken
										value: #|;
										start: currentToken start + 1]
								ifFalse: [ args add:(self parserError: '''|'' expected')]]]
				ifFalse: 
					[(currentToken isSpecial and: [currentToken value = $]]) 
						ifFalse: [ args add:(self parserError: '''|'' expected')]]].
	node
		arguments: args;
		colons: colons.
	^node adaptToArgumentBindingKind
]
