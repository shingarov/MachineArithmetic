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
	^ΛκParser
]

{ #category : #running }
SpriteLangTest >> processString: source [
	| qe qs e |
	qe := self parserClass parse: source.
	self deny: qe isPetitFailure.
	qs := qe first.
	e := qe last.
	self assert: (e solveWithQualifiers: qs) equals: self expectedResult
]
