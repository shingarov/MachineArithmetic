Class {
	#name : #ExistentiallyBoundVariableNode,
	#superclass : #RBSortedArgumentNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #visiting }
ExistentiallyBoundVariableNode >> acceptVisitor: aProgramNodeVisitor [
	^aProgramNodeVisitor visitExistentiallyBoundVariableNode: self
]

{ #category : #'constraint generation' }
ExistentiallyBoundVariableNode >> quantificationBlockClass [
	^ExistentialQuantificationNode
]
