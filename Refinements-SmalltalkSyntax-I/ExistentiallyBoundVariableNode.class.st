Class {
	#name : #ExistentiallyBoundVariableNode,
	#superclass : #RBSortedArgumentNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #'constraint generation' }
ExistentiallyBoundVariableNode >> quantificationBlockClass [
	^ExistentialQuantificationNode
]
