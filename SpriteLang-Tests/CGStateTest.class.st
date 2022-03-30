Class {
	#name : #CGStateTest,
	#superclass : #TestCase,
	#category : #'SpriteLang-Tests'
}

{ #category : #tests }
CGStateTest >> testFreshInteger [
	CGState reset.
	self assert: CGState current freshInt equals: 0.
	self assert: CGState current freshInt equals: 1.
	self assert: CGState current freshInt equals: 2.
	CGState reset.
	self assert: CGState current freshInt equals: 0.

]
