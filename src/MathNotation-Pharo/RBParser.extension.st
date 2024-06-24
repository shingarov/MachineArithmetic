Extension { #name : #RBParser }

{ #category : #'*MathNotation-Pharo' }
RBParser >> parseHole [
	| token node |
	token := currentToken.
	self step.
	node := SectionArgumentNode newAt: token start.
	self addCommentsTo: node.
	^node

]

{ #category : #'*MathNotation-Pharo' }
RBParser >> parsePrimitiveObject [
	currentToken isHole ifTrue: [^self parseHole].
	currentToken isIdentifier ifTrue: [^self parsePrimitiveIdentifier].
	(currentToken isLiteralToken and: [currentToken isMultiKeyword not]) 
		ifTrue: [^self parsePrimitiveLiteral].
	currentToken isLiteralArrayToken
		ifTrue: 
			[^currentToken isForByteArray 
				ifTrue: [self parseLiteralByteArray]
				ifFalse: [self parseLiteralArray]].
	currentToken isSpecial
		ifTrue: 
			[currentToken value = $[ ifTrue: [^self saveCommentsDuring:[self parseBlock]].
			currentToken value = $( ifTrue: [^self parseParenthesizedExpression].
			currentToken value = ${ ifTrue: [^self parseArray]].
	^ self parserError: 'Variable or expression expected'
]
