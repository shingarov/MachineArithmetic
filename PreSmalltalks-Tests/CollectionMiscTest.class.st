Class {
	#name : #CollectionMiscTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
CollectionMiscTest >> testMapEither [
	| collection classifier bs_cs |
	collection := #(1 2 3).
	classifier := [ :j | j even ifTrue: [ Either right: j ] ifFalse: [ Either left: j ] ].
	bs_cs := collection mapEither: classifier.
	self assert: bs_cs key   equals: #(1 3).
	self assert: bs_cs value equals: #(2).
]
