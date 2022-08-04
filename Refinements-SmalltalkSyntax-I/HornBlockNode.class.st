Class {
	#name : #HornBlockNode,
	#superclass : #RBBlockNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #visiting }
HornBlockNode >> acceptVisitor: aProgramNodeVisitor [
	(aProgramNodeVisitor respondsTo: #visitHornNode:) ifFalse: [ ^aProgramNodeVisitor visitBlockNode: self ].
	^aProgramNodeVisitor visitHornNode: self
]
