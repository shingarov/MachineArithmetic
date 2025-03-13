Class {
	#name : #PParserExtensionsTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
PParserExtensionsTest >> testParens [
	self assert: ($x asParser parens parse: '()') isNil.
	self assert: ($x asParser parens parse: '(x)') = $x.
	self assert: ($x asParser parens parse: '( x  )') = $x.
	self assert: ($x asParser parens parse: '(  )') isNil

]

{ #category : #tests }
PParserExtensionsTest >> testPostconditionFail [
	| intP intOtherThan42P p |
	intP := #digit asParser plus flatten ==> #asInteger.
	intOtherThan42P := PPPostconditionalParser on: intP block: [ :x | x~=42 ].
	p := #letter asParser, intOtherThan42P, #letter asParser.

	self assert: (p parse: 'a42z') isPetitFailure
]

{ #category : #tests }
PParserExtensionsTest >> testPostconditionSucceed [
	| intP intOtherThan42P p |
	intP := #digit asParser plus flatten ==> #asInteger.
	intOtherThan42P := PPPostconditionalParser on: intP block: [ :x | x~=42 ].
	p := #letter asParser, intOtherThan42P, #letter asParser.

	self deny: (p parse: 'a12345z') isPetitFailure
]
