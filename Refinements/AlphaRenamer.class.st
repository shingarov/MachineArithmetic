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
	(self hasSeen: varName)
		ifTrue: [ 
			| newVarName |
			newVarName := varName varSubscript: (self timesSeen: varName).
			self notice: varName.
			newTerm := (term rename: varName to: newVarName) uniq1: self.
			self notice: newVarName.
	 ] ifFalse: [ 
			self notice: varName.
			newTerm := stayBlock value.
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

{ #category : #'as yet unclassified' }
AlphaRenamer >> popName: x [
	| val adjusted |
	val := self seenSymbols at: x.
	adjusted := val key -> val value allButFirst.
	self seenSymbols at: x put: adjusted
]

{ #category : #printing }
AlphaRenamer >> printOn: aStream [
	aStream nextPutAll: 'α saw '.
	self seenSymbols isEmpty ifTrue: [ ^aStream nextPut: Character emptySet ].
	self seenSymbols associations
		do: [ :ass | aStream nextPutAll: ass key; nextPut: $:; nextPutAll: ass value printString ]
		separatedBy: [ aStream nextPut: $  ]
	
]

{ #category : #'as yet unclassified' }
AlphaRenamer >> rename: e [
"
rename :: Pred -> RenameMap -> Pred
cf. Transformations.hs
"
	| m′ |
	m′ := self seenSymbols keysAndValuesCollectMaybe: [ :k :v |
		v value isEmpty
			ifTrue: [nil]
			ifFalse: [k -> (k numSym: v value first)] ].
	(m′ allSatisfy: [ :eachAss | eachAss key = eachAss value ]) ifTrue: [ ^e ].
	^e substPred: (Subst newFromAssociations: m′)
]

{ #category : #queries }
AlphaRenamer >> seenSymbols [
	seenSymbols isNil ifTrue: [ seenSymbols := RenameMap new ].
	^ seenSymbols
]

{ #category : #queries }
AlphaRenamer >> timesSeen: varName [
	^self seenSymbols at: varName ifAbsent: [0]
]

{ #category : #'as yet unclassified' }
AlphaRenamer >> uVariable: x [ 
	| i |
	self seenSymbols replaceKey: x using: #pushName.
	i := (self seenSymbols at: x) value first.
	^x numSym: i
]
