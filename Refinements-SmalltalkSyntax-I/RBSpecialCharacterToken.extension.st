Extension { #name : #RBSpecialCharacterToken }

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBSpecialCharacterToken >> startsBlockArg [
	^':∀∃' includes: self value
]
