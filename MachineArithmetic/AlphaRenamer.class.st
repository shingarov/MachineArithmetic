Class {
	#name : #AlphaRenamer,
	#superclass : #Object,
	#instVars : [
		'seenSymbols'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #queries }
AlphaRenamer >> hasSeen: varName [
	^self seenSymbols includesKey: varName
]

{ #category : #rewriting }
AlphaRenamer >> notice: varName [
	self seenSymbols at: varName put: (
		(self hasSeen: varName)
			ifTrue: [ (self seenSymbols at: varName) + 1 ]
			ifFalse: [ 1 ]
		)
]

{ #category : #queries }
AlphaRenamer >> seenSymbols [
	"All the symbols we have already seen before;
	each symbol is assigned a number how many times we've seen it."
	seenSymbols isNil ifTrue: [ seenSymbols := Dictionary new ].
	^ seenSymbols
]

{ #category : #queries }
AlphaRenamer >> timesSeen: varName [
	^self seenSymbols at: varName ifAbsent: [0]
]
