Extension { #name : #False }

{ #category : #'*Refinements' }
False >> prop [
"
instance Predicate Bool where
  prop True  = PTrue
  prop False = PFalse
"
	^Expr PFalse
]
