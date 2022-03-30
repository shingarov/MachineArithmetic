Class {
	#name : #SpriteLangTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests'
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
	^SpriteParser
]

{ #category : #running }
SpriteLangTest >> processString: source [
	| q |
	q := self parserClass parse: source.
	self deny: q isPetitFailure.
	self assert: q solve equals: self expectedResult
]
