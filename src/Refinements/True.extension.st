Extension { #name : #True }

{ #category : #'*Refinements' }
True >> prop [
"
instance Predicate Bool where
  prop True  = PTrue
  prop False = PFalse
"
	^Expr PTrue
]
