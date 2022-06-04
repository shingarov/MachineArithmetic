Class {
	#name : #AllCombinationsTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
AllCombinationsTest >> test1 [
	self assert: #( (1 2)  (3 4) ) allCombinations
		equals: #( (1 3) (1 4) (2 3) (2 4) )

]

{ #category : #tests }
AllCombinationsTest >> test2 [
	self assert: #( (1 2)  (10) (300 400) ) allCombinations
		equals: #( (1 10 300) (1 10 400) (2 10 300) (2 10 400) )

]
