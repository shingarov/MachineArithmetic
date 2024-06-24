Extension { #name : #RBNode }

{ #category : #'*MathNotation-Pharo' }
RBNode >> parserError: aString [
	self parserError: aString in: RBParser findContextReceivingMe
]

{ #category : #'*MathNotation-Pharo' }
RBNode >> parserError: aString in: parsersContext [
	parsersContext return: (parsersContext receiver parserError: aString)
]
