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
	| prog unsafe |
	prog := ΛκParser parse: source.
	self deny: prog isPetitFailure.

	unsafe := prog solve.
	self deny: unsafe isSafe.
	unsafe bads do:[:bad |
		self assert: (bad value value isKindOf: Z3Model)
	].
]
