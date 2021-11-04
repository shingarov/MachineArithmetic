Class {
	#name : #Left,
	#superclass : #Either,
	#category : #'MachineArithmetic-Core'
}

{ #category : #accessing }
Left >> left: leftBlock right: rightBlock [
	^leftBlock value: x
]
