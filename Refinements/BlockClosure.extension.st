Extension { #name : #BlockClosure }

{ #category : #'*Refinements' }
BlockClosure >> runCMwithIncrement: γ [
	^self runReader: #incrementer initialState: {0}
]

{ #category : #'*Refinements' }
BlockClosure >> runHotel [
	^self runReader: #hotel initialState: IndexedSet new
]
