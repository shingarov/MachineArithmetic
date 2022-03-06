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
SpriteLangTest >> process: testName [
	| q |
	q := self parserClass parse: (self readSourceOf: testName).
	self deny: q isPetitFailure.
	self assert: q solve equals: self expectedResult
]

{ #category : #'as yet unclassified' }
SpriteLangTest >> readSourceOf: testName [
	| fqFN stream txt |
	fqFN := self spriteRepoRoot / 'test' / self languageLevel / self polarity / (testName, '.re').
	stream := fqFN readStream.
	txt := stream contents.
	stream close.
	^txt
]

{ #category : #'as yet unclassified' }
SpriteLangTest >> spriteRepoRoot [
	^FileSystem / '/home/boris/work/sprite-lang'
]
