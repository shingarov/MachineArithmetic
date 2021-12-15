Class {
	#name : #ColjectIntoTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
ColjectIntoTest >> testColjectInto1 [
	| coll result |
	coll := 1 to: 10.
	result := coll colject: 0 into: [ :a :b | a+b -> a ].
	self assert: result key equals: 55.
	self assert: result value equals: #(0 1 3 6 10 15 21 28 36 45)
]

{ #category : #tests }
ColjectIntoTest >> testColjectInto2 [
	| coll result |
	coll := 1 to: 5.
	result := coll colject: '0' into: [ :a :b | a, b printString -> a ].
	self assert: result key equals: '012345'.
	self assert: result value equals: #('0' '01' '012' '0123' '01234')
]

{ #category : #tests }
ColjectIntoTest >> testZvon1 [
	| result |
	result := #(9 6 3) colject: 5 into: [ :x :y | x -> (x*y) ].
	self assert: result key equals: 5.
	self assert: result value equals: #(45 30 15)
]

{ #category : #tests }
ColjectIntoTest >> testZvon2 [
	| result |
	result := #(2 4 8) colject: 5 into: [ :x :y | (x+y) -> (x*y) ].
	self assert: result key equals: 19.
	self assert: result value equals: #(10 28 88)
]
