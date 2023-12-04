Class {
	#name : #SpriteLangTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #running }
SpriteLangTest >> processString: source [
	self subclassResponsibility
]

{ #category : #running }
SpriteLangTest >> proveSafe: source [
	| prog |
	prog := ΛκParser parse: source.
	self deny: prog isPetitFailure.
	self assert: prog solve isSafe
]

{ #category : #running }
SpriteLangTest >> proveUnsafe: source [
	| prog |
	prog := ΛκParser parse: source.
	self deny: prog isPetitFailure.
	self deny: prog solve isSafe
]
