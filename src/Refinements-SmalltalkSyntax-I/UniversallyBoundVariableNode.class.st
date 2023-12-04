Class {
	#name : #UniversallyBoundVariableNode,
	#superclass : #RBSortedArgumentNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #visiting }
UniversallyBoundVariableNode >> acceptVisitor: aProgramNodeVisitor [
	^aProgramNodeVisitor visitUniversallyBoundVariableNode: self
]

{ #category : #'constraint generation' }
UniversallyBoundVariableNode >> quantificationBlockClass [
	^UniversalQuantificationNode
]
