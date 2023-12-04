Class {
	#name : #PsBooleanTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
PsBooleanTest >> testAnd1 [
	self assert: (Boolean and: { true . true })
]

{ #category : #tests }
PsBooleanTest >> testAnd2 [
	self deny: (Boolean and: { false . true })
]

{ #category : #tests }
PsBooleanTest >> testAndV [
	self assert: (Boolean and: #())
]

{ #category : #tests }
PsBooleanTest >> testOr1 [
	self assert: (Boolean or: { true . false })
]

{ #category : #tests }
PsBooleanTest >> testOr2 [
	self deny: (Boolean or: { false . false })
]

{ #category : #tests }
PsBooleanTest >> testOrV [
	self deny: (Boolean or: #())
]
