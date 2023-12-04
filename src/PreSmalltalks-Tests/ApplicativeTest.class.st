Class {
	#name : #ApplicativeTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
ApplicativeTest >> testApplicativeProduct [
	| fs xs |
	fs := { [ :x | x*2 ].
	        [ :x | x+10 ]
	      }.
	xs := { 1 . 2 . 3 }.
	self assert: fs <*> xs equals: { 2 . 4 . 6 . 11 . 12 . 13 }
]

{ #category : #tests }
ApplicativeTest >> testLiftA2 [
	| actions |
	actions := [ :x :y | x->y ] liftA2.
	self assert: (actions value: {3} value: {5}) equals: { 3->5 }
	
]

{ #category : #tests }
ApplicativeTest >> testPureArray [
{ 1 . 2 } collect: [ :x | x squared ].
	self assert: (Array pure value: 42) equals: {42}
	
]

{ #category : #tests }
ApplicativeTest >> testPureDictionary [
	self
		assert: (Dictionary pure value: 1->'one')
		equals: (Dictionary new at: 1 put: 'one'; yourself)
]
