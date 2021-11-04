Class {
	#name : #Right,
	#superclass : #Either,
	#category : #'MachineArithmetic-Core'
}

{ #category : #accessing }
Right >> left: leftBlock right: rightBlock [
	^rightBlock value: x
]
