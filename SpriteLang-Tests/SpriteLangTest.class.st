Class {
	#name : #SpriteLangTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #running }
SpriteLangTest >> expectedResult [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
SpriteLangTest >> languageLevel [
	^self class name first: 2
]

{ #category : #'as yet unclassified' }
SpriteLangTest >> parserClass [
	^ΛκParser
]

{ #category : #running }
SpriteLangTest >> processString: source [
	| prog |
	prog := self parserClass parse: source.
	self deny: prog isPetitFailure.
	self assert: prog solve equals: self expectedResult
]
