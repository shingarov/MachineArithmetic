Class {
	#name : #SpriteLangTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #running }
SpriteLangTest >> parse: source [
	| prog |
	prog := self parserClass parse: source.
	self deny: prog isPetitFailure.
	^prog
]

{ #category : #running }
SpriteLangTest >> parserClass [
	^ΛκParser
]

{ #category : #running }
SpriteLangTest >> processString: source [
	self subclassResponsibility
]

{ #category : #running }
SpriteLangTest >> proveSafe: source [
	[
	| safe |
	safe := (self parse: source) solve.
	self assert: safe isSafe
	] runReader: #bvLengthInference initialState: BvLengthInference new
]

{ #category : #running }
SpriteLangTest >> proveUnsafe: source [
	[
	| unsafe |
	unsafe := (self parse: source) solve.
	self deny: unsafe isSafe.
	unsafe bads do:[ :bad | self assert: (bad value value isKindOf: Z3Model) ]
	] runReader: #bvLengthInference initialState: BvLengthInference new
]
