Extension { #name : #BlockClosure }

{ #category : #'*Refinements' }
BlockClosure >> runCM0 [
	"^[self runHotel] runWithIncrementingIntegers"
	^self runHotel
]

{ #category : #'*Refinements' }
BlockClosure >> runHotel [
	^self runReader: #hotel initialState: IndexedSet new
]
