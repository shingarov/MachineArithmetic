Class {
	#name : #UniversalQuantificationNode,
	#superclass : #RBQuantificationBlockNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #'constraint generation' }
UniversalQuantificationNode >> constraintClass [
	^CstrAll
]
