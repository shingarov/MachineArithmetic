Extension { #name : #FAbs }

{ #category : #'*PLE' }
FAbs >> matchSorts: s2 [
"
go (FAbs _ t1)   (FAbs _ t2)   = go t1 t2
"
	^(s2 isKindOf: FAbs)
		ifTrue: [ sort matchSorts: s2 sort ]
		ifFalse: [ super matchSorts: s2 ]
]
