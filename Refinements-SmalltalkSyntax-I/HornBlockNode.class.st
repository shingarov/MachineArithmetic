Class {
	#name : #HornBlockNode,
	#superclass : #RBBlockNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #visiting }
HornBlockNode >> acceptVisitor: aProgramNodeVisitor [
	^aProgramNodeVisitor visitHornNode: self
]

{ #category : #accessing }
HornBlockNode >> formattedCode [
	^'...?...'
]
