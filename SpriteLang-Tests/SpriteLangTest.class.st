Class {
	#name : #SpriteLangTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #running }
SpriteLangTest >> assertExpectedResult: aFixResult [
	self subclassResponsibility
]

{ #category : #running }
SpriteLangTest >> processString: source [
	| prog |
	prog := ΛκParser parse: source.
	self deny: prog isPetitFailure.
	self assertExpectedResult: prog solve
]
