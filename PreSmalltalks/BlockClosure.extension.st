Extension { #name : #BlockClosure }

{ #category : #'*PreSmalltalks' }
BlockClosure >> runReader: marker initialState: s [
	^self value
]

{ #category : #'*PreSmalltalks' }
BlockClosure >> runWithIncrementingIntegers [
	^self runReader: #incrementer initialState: {0}
]
