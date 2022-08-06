Extension { #name : #RBBlockNode }

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBBlockNode >> adaptToArgumentBindingKind [
	"The binding of bound arguments come in many different kinds;
	 for example, d in ∫f(x)dx,
	 or λ in λx.fx,
	 or ∀ in ∀x.Px.
	 When parsing a block initially, we first instantiate a generic RBBlockNode.
	 Later when we have enough information about what kind the binding is,
	 the block mutates to the correct class.
	"
	| answer |
	(arguments notEmpty and: [ arguments first class = RBUniversallyBoundVariableNode ]) ifTrue: [
		answer := arguments inject: self into: [ :blockSoFar :eachArg | eachArg forceCorrectClassOf: blockSoFar ].
		answer checkSaneArguments.
		^answer
	].
^self
]

{ #category : #'*Refinements-SmalltalkSyntax-I' }
RBBlockNode >> checkSaneArguments [
]
