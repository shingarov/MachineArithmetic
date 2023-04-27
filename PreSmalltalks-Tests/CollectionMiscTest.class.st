Class {
	#name : #CollectionMiscTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
CollectionMiscTest >> testGroupMap [
"
groupMap even [1,2,3]  >>  fromList [(False,[3,1]),(True,[2])]
"
	| collection grouped |
	collection := #(1 2 3).
	grouped := collection groupMap: #even.
	self assert: grouped keys asSet equals: {false . true} asSet.
	self assert: (grouped at: true)  equals: {2}.
	self assert: (grouped at: false) equals: {3 . 1}.
]

{ #category : #tests }
CollectionMiscTest >> testInsertsAbsent [
	| dict1 dict2 |
	dict1 := Dictionary new.
	dict2 := dict1 inserts: 'a' at: 1.
	self assert: (dict2 at: 1) equals: {'a'}.
	self deny: dict1=dict2 "non-destructiveness"
]

{ #category : #tests }
CollectionMiscTest >> testInsertsPresent [
	| dict1 dict2 dict3 |
	dict1 := Dictionary new.
	dict2 := dict1 inserts: 'a' at: 1.
	dict3 := dict2 inserts: 'a' at: 1.
	self assert: (dict3 at: 1) equals: {'a' . 'a'}.
]

{ #category : #tests }
CollectionMiscTest >> testMapEither [
	| collection classifier bs_cs |
	collection := #(1 2 3).
	classifier := [ :j | j even ifTrue: [ Either right: j ] ifFalse: [ Either left: j ] ].
	bs_cs := collection mapEither: classifier.
	self assert: bs_cs key   equals: #(1 3).
	self assert: bs_cs value equals: #(2).
]
