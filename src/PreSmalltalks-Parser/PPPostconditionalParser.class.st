"
A PPPostconditionalParser is similar to PPConditionalParser but works in reverse order:
if *first* invokes the delegate and (if that succeeds) tests the predicate block *after*,
using the delegate's output as the argument to the block.
"
Class {
	#name : #PPPostconditionalParser,
	#superclass : #PPDelegateParser,
	#instVars : [
		'block'
	],
	#category : #'PreSmalltalks-Parser'
}

{ #category : #'instance creation' }
PPPostconditionalParser class >> on: aPPParser block: block [
	^ (self on: aPPParser)
		block: block;
		yourself
]

{ #category : #accessing }
PPPostconditionalParser >> block: aBlock [
	block := aBlock
]

{ #category : #parsing }
PPPostconditionalParser >> parseOn: aPPContext [
	| result |
	result := parser parseOn: aPPContext.
	^result isPetitFailure
		ifTrue: [ result ]
		ifFalse: [ (block value: result)
			ifTrue: [ result ]
			ifFalse: [ PPFailure message: block asString, ' was not evaluated to true.' context: aPPContext ] ]
]
