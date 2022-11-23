Extension { #name : #BlockClosure }

{ #category : #'*Refinements' }
BlockClosure >> runCMwithIncrement: γ [
	γ hotel: IndexedSet new.
	^self runReader: #incrementer initialState: {0}
]
