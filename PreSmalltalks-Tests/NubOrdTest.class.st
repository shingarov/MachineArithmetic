Class {
	#name : #NubOrdTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
NubOrdTest >> test0 [
	self assert: #() nubOrd equals: #()
]

{ #category : #tests }
NubOrdTest >> test1 [
	self assert: #(1) nubOrd equals: #(1)
]

{ #category : #tests }
NubOrdTest >> test2Eq [
	self assert: #(1 1) nubOrd equals: #(1)
]

{ #category : #tests }
NubOrdTest >> test2Neq [
	self assert: #(1 2) nubOrd equals: #(1 2)
]

{ #category : #tests }
NubOrdTest >> test3Back [
	self assert: #(1 2 2) nubOrd equals: #(1 2)
]

{ #category : #tests }
NubOrdTest >> test3Front [
	self assert: #(1 1 2) nubOrd equals: #(1 2)
]

{ #category : #tests }
NubOrdTest >> testMid [
	self assert: #(1 2 2 1) nubOrd equals: #(1 2 1)
]
