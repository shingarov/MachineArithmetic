Extension { #name : #FObj }

{ #category : #'*PLE' }
FObj >> matchSorts: s2 [
"
go (FObj x)      {-FObj-} y    = [(x, y)]
"
	^{symbol -> s2}
	
]
