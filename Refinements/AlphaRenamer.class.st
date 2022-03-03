Class {
	#name : #AlphaRenamer,
	#superclass : #Object,
	#instVars : [
		'seenSymbols'
	],
	#category : #Refinements
}

{ #category : #queries }
AlphaRenamer >> hasSeen: varName [
	^self seenSymbols includesKey: varName
]

{ #category : #rewriting }
AlphaRenamer >> if: varName ifStays: stayBlock in: term [
	| newTerm |
"self halt."
	(self hasSeen: varName)
		ifTrue: [ 
			| newVarName |
			newVarName := varName varSubscript: (self timesSeen: varName).
			self notice: varName.
			newTerm := (term rename: varName to: newVarName renamer: self) uniq1: self.
			self notice: newVarName.
	 ] ifFalse: [ 
			newTerm := stayBlock value.
			self notice: varName
	 ].
	^newTerm
	
]

{ #category : #rewriting }
AlphaRenamer >> notice: varName [
	self seenSymbols at: varName put: (
		(self hasSeen: varName)
			ifTrue: [ (self seenSymbols at: varName) + 1 ]
			ifFalse: [ 1 ]
		)
]

{ #category : #printing }
AlphaRenamer >> printOn: aStream [
	aStream nextPutAll: 'α saw '.
	self seenSymbols isEmpty ifTrue: [ ^aStream nextPut: Character emptySet ].
	self seenSymbols associations
		do: [ :ass | aStream nextPutAll: ass key; nextPut: $:; nextPutAll: ass value printString ]
		separatedBy: [ aStream nextPut: $  ]
	
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
