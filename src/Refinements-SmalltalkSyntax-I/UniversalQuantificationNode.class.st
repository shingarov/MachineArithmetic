Class {
	#name : #UniversalQuantificationNode,
	#superclass : #QuantificationBlockNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #visiting }
UniversalQuantificationNode >> acceptVisitor: aProgramNodeVisitor [
	^aProgramNodeVisitor visitUniversalQuantificationNode: self
]

{ #category : #'constraint generation' }
UniversalQuantificationNode >> constraintClass [
	^CstrAll
]
