Extension { #name : #Set }

{ #category : #'*DepthFirstSearch' }
Set >> sliceEdges: triples [
	"NB this code assumes keys and nodes are always equal,
	 because this is only used over constraint Ids.
	 This should be moved from DFS to Refinements."
	| subCollection |
	subCollection := triples select: [ :aTriple | self includes: aTriple third ].
	^subCollection collect: [ :aTriple |
		{ 
		aTriple first.
		aTriple second select: [ :aSuccessor | self includes: aSuccessor ].
		aTriple third
		} ]
]
