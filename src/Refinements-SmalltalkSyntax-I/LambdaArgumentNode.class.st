Class {
	#name : #LambdaArgumentNode,
	#superclass : #BoundArgumentNode,
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #parsing }
LambdaArgumentNode class >> parseBoundVariableNode: x parser: anRBParser [
	^x
]

{ #category : #visiting }
LambdaArgumentNode >> acceptVisitor: aProgramNodeVisitor [
	^aProgramNodeVisitor visitLambdaArgumentNode: self
]
