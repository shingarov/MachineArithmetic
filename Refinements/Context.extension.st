Extension { #name : #Context }

{ #category : #'*Refinements' }
Context class >> currentElabEnv [
	| elabContext |
	elabContext := thisContext sender findContextSuchThat: [ :ctx |
		ctx isBlockContext not and: [
			ctx methodSelector = #elab: ] ].
	^elabContext tempNamed: #anElabEnv
]
