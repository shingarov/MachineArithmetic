Extension { #name : #UndefinedObject }

{ #category : #'*Refinements' }
UndefinedObject >> edgeRankCut [
	^self
]

{ #category : #'*Refinements' }
UndefinedObject >> elaborate: γ [
"
instance (Elaborate a) => (Elaborate (Maybe a)) where
  elaborate x env t = fmap (elaborate x env) t
"
	^nil
]

{ #category : #'*Refinements' }
UndefinedObject >> pushName [
	^ 0 -> {0}
]

{ #category : #'*Refinements' }
UndefinedObject >> vv [
	^String vvName
]
