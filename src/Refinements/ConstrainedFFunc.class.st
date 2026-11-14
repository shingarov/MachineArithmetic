Class {
	#name : #ConstrainedFFunc,
	#superclass : #FFunc,
	#instVars : [
		'typeLevelBlock'
	],
	#category : #'Refinements-Sorts'
}

{ #category : #accessing }
ConstrainedFFunc >> typeLevelBlock: anObject [
	typeLevelBlock := anObject.
	^self
]
