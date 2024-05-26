Extension { #name : #Context }

{ #category : #'*PreSmalltalks' }
Context class >> readState: marker [
	| launchContext |
	launchContext := thisContext sender findContextSuchThat: [ :ctx |
		ctx isBlockContext not and: [
			ctx methodSelector = #runReader:initialState: and: [ 
				(ctx tempNamed: #marker) = marker ] ] ].
	launchContext isNil ifTrue: [ ^self error: 'No state context: ', marker ].
	^launchContext tempNamed: #s
]

{ #category : #'*PreSmalltalks' }
Context >> toDictionary [
	^(Dictionary newFromAssociations: (self tempNames collect: [ :t | t -> (self tempNamed: t) ]))
		at: 'self' put: self receiver;
		yourself
]
