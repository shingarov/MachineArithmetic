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
OCASTTranslator >> visitHornNode: aHornNode [ 
	"| arg |
	methodBuilder pushLiteralVariable: HornQuery binding.
	arg := aQuantificationBlockNode arguments first.
	methodBuilder pushLiteral: arg name.
	valueTranslator visitNode: arg sort.
	arg reft isNil
		ifTrue: [ methodBuilder pushLiteral: nil ]
		ifFalse:  [ valueTranslator visitNode: arg reft ].
	self visitBlockNode: aQuantificationBlockNode.
	methodBuilder send: #varName:τ:r:smalltalkBlock: ."



	methodBuilder pushLiteralVariable: HornQuery binding.
	self visitHornArguments: aHornNode arguments.
	self visitBlockNode: aHornNode.
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
OCASTTranslator >> visitQuantificationNode: aQuantificationBlockNode [ 
	| arg |
	methodBuilder pushLiteralVariable: aQuantificationBlockNode constraintClass binding.
	arg := aQuantificationBlockNode arguments first.
	methodBuilder pushLiteral: arg name.
	valueTranslator visitNode: arg sort.
	arg reft isNil
		ifTrue: [ methodBuilder pushLiteral: nil ]
		ifFalse:  [ valueTranslator visitNode: arg reft ].
	self visitBlockNode: aQuantificationBlockNode.
	methodBuilder send: #varName:τ:r:smalltalkBlock: .

]
