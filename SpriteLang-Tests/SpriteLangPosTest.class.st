Class {
	#name : #SpriteLangPosTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #running }
SpriteLangPosTest >> assertExpectedResult: aFixResult [
	^self assert: aFixResult isSafe
]
