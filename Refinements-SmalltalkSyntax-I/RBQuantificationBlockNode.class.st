Class {
	#name : #RBQuantificationBlockNode,
	#superclass : #RBBlockNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #'as yet unclassified' }
RBQuantificationBlockNode >> acceptVisitor: aProgramNodeVisitor [
	(aProgramNodeVisitor respondsTo: #visitQuantificationNode:) ifFalse: [ ^aProgramNodeVisitor visitBlockNode: self ].
	^aProgramNodeVisitor visitQuantificationNode: self

]

{ #category : #'as yet unclassified' }
RBQuantificationBlockNode >> checkSaneArguments [
	arguments size = 1 ifFalse: [ arguments add: (self parserError: 'Exactly one bound variable expected') ]
]
