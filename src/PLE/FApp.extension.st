Extension { #name : #FApp }

{ #category : #'*PLE' }
FApp >> matchSorts: s2 [
"
go (FApp s1 t1)  (FApp s2 t2)  = go s1 s2 ++ go t1 t2
"
	^(s2 isKindOf: FApp)
		ifTrue: [ (s matchSorts: s2 s), (t matchSorts: s2 t) ]
		ifFalse: [ super matchSorts: s2 ]
]
