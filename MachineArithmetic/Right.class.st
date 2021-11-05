Class {
	#name : #Right,
	#superclass : #Either,
	#category : #'MachineArithmetic-Core'
}

{ #category : #testing }
Right >> isLeft [
	^false
]

{ #category : #testing }
Right >> isRight [
	^true
]

{ #category : #accessing }
Right >> left: leftBlock right: rightBlock [
	^rightBlock value: x
]
