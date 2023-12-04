Class {
	#name : #Right,
	#superclass : #Either,
	#category : #PreSmalltalks
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
