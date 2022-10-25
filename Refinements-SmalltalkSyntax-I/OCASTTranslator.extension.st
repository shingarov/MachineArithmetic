Extension { #name : #OCASTTranslator }

{ #category : #'*Refinements-SmalltalkSyntax-I' }
OCASTTranslator >> visitHornArguments: hornVariableNodes [
	| array |
	array := RBArrayNode statements: hornVariableNodes.
	self visitLargeArrayNode: array. "array acceptVisitor: self"

	"
	methodBuilder pushLiteralVariable: HVar binding.
	methodBuilder pushLiteral: arg name.
	valueTranslator visitNode: arg argSorts.
	methodBuilder send: #name:argSorts: ."
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
OCASTTranslator >> visitHornNode: n [
	methodBuilder pushLiteralVariable: HornQuery binding.
	self visitHornArguments: n arguments.
	self visitBlockNode: n.
	methodBuilder send: #hornVariables:smalltalkBlock:

]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
OCASTTranslator >> visitHornVariableNode: aHornVariableNode [
	methodBuilder pushLiteralVariable: HVar binding.
	methodBuilder pushLiteral: aHornVariableNode name.
	valueTranslator visitNode: aHornVariableNode argSorts.
	methodBuilder send: #name:argSorts:
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
