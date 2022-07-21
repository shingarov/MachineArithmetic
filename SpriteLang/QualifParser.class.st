Class {
	#name : #QualifParser,
	#superclass : #RefinementParser,
	#category : #SpriteLang
}

{ #category : #accessing }
QualifParser >> qual [
	^ 'qualif ' asParser,
	self upperId,
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
	^ self lowerId,
		$: asParser,
		(('int' asParser ==> [ :_x | Int sort ]) / ('bool' asParser  ==> [ :_x | Bool sort ]))
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
