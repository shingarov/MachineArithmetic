Class {
	#name : #QuantificationBlockNode,
	#superclass : #RBBlockNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #visiting }
QuantificationBlockNode >> acceptVisitor: aProgramNodeVisitor [
	(aProgramNodeVisitor respondsTo: #visitQuantificationNode:) ifFalse: [ ^aProgramNodeVisitor visitBlockNode: self ].
	^aProgramNodeVisitor visitQuantificationNode: self

]

{ #category : #'constraint generation' }
QuantificationBlockNode >> constraintClass [
	self subclassResponsibility
]
