Class {
	#name : #ExistentialQuantificationNode,
	#superclass : #QuantificationBlockNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #visiting }
ExistentialQuantificationNode >> acceptVisitor: aProgramNodeVisitor [
	^aProgramNodeVisitor visitExistentialQuantificationNode: self
]

{ #category : #'constraint generation' }
ExistentialQuantificationNode >> constraintClass [
	^CstrAny
]
