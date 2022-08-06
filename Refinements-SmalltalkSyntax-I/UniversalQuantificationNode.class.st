Class {
	#name : #UniversalQuantificationNode,
	#superclass : #QuantificationBlockNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #'constraint generation' }
UniversalQuantificationNode >> constraintClass [
	^CstrAll
]
