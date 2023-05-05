Class {
	#name : #SpriteLangNegTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #running }
SpriteLangNegTest >> assertExpectedResult: aFixResult [
	^self deny: aFixResult isSafe
]
