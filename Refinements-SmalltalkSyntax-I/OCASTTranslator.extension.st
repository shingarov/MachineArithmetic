Extension { #name : #OCASTTranslator }

{ #category : #'*Refinements-SmalltalkSyntax-I' }
OCASTTranslator >> visitHornNode: n [
	| arg |
	methodBuilder pushLiteralVariable: HVarShit binding.
	methodBuilder pushLiteralVariable: HVar binding.
	arg := n arguments first. "a HornVariableNode"
	methodBuilder pushLiteral: arg name.
	valueTranslator visitNode: arg argSorts.
	methodBuilder send: #name:argSorts: .
	self visitBlockNode: n.
	methodBuilder send: #hvar:block: .

]

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
