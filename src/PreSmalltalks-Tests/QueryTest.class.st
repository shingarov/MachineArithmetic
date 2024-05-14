Class {
	#name : #QueryTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
QueryTest >> testBasic [
	| answer reply |

	answer := Object new.

	TestQuery answer: answer do:[
		reply := TestQuery query.
	].

	self assert: answer == reply
]

{ #category : #tests }
QueryTest >> testDefaultAnswer [
	| answer |


	answer := TestQuery query.

	self assert: answer equals: TestQuery basicNew defaultResumeValue

]

{ #category : #tests }
QueryTest >> testNested [
	| outer inner reply |

	outer := Object new.
	inner := Object new.

	TestQuery answer: outer do:[
		reply := TestQuery query.

		TestQuery answer: inner do:[
			reply := TestQuery query.
		]
	].

	self assert: inner == reply
]
