Class {
	#name : #QualifParser,
	#superclass : #RefinementParser,
	#category : #'SpriteLang-Parsing'
}

{ #category : #accessing }
QualifParser >> qual [
	^ 'qualif ' asParser,
	NNFParser upperId,
	self qualParams,
	':' asParser,
	#space asParser plus,
	matchedParen parens
	==> [ :x | Qualifier
			name: x second 
			params: x third 
			body: (DecidableRefinement text: x sixth) ]
]

{ #category : #accessing }
QualifParser >> qualParam [
	^ NNFParser lowerId,
		$: asParser,
		(rtype ==> [ :x | x rtypeSort ])
	==> [ :x | QualParam symbol: x first sort: x last ]
]

{ #category : #accessing }
QualifParser >> qualParams [
	^self qualParam commaList
]

{ #category : #grammar }
QualifParser >> start [
	^self qual
]
