Extension { #name : #OCASTTranslator }

{ #category : #'*Refinements-SmalltalkSyntax-I' }
OCASTTranslator >> visitQuantificationNode: anRBQuantificationBlockNode [ 
	| arg |
	methodBuilder pushLiteralVariable: SickFuck binding.
	arg := anRBQuantificationBlockNode arguments first.
	methodBuilder pushLiteral: arg name.
	valueTranslator visitNode: arg sort.
	arg reft isNil
		ifTrue: [ methodBuilder pushLiteral: nil ]
		ifFalse:  [ valueTranslator visitNode: arg reft ].
	self visitBlockNode: anRBQuantificationBlockNode.
	methodBuilder send: #x:s:r:b: .

]
