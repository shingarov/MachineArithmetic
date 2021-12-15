Class {
	#name : #Left,
	#superclass : #Either,
	#category : #PreSmalltalks
}

{ #category : #testing }
Left >> isLeft [
	^true
]

{ #category : #testing }
Left >> isRight [
	^false
]

{ #category : #accessing }
Left >> left: leftBlock right: rightBlock [
	^leftBlock value: x
]
