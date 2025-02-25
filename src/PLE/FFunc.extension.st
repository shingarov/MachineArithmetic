Extension { #name : #FFunc }

{ #category : #'*PLE' }
FFunc >> matchSorts: s2 [
"
go (FFunc s1 t1) (FFunc s2 t2) = go s1 s2 ++ go t1 t2
"
	^(s2 isKindOf: FFunc)
		ifTrue: [ (from matchSorts: s2 from), (to matchSorts: s2 to) ]
		ifFalse: [ super matchSorts: s2 ]
]
