Extension { #name : #BlockClosure }

{ #category : #'*Refinements' }
BlockClosure >> runCM0 [
	^self runReader: #incrementer initialState: {42}
]

{ #category : #'*Refinements' }
BlockClosure >> runHotel [
	^self runReader: #hotel initialState: Hotel new
]
