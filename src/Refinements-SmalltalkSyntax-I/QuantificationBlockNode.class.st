Class {
	#name : #QuantificationBlockNode,
	#superclass : #RBBlockNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #'constraint generation' }
QuantificationBlockNode >> constraintClass [
	self subclassResponsibility
]
