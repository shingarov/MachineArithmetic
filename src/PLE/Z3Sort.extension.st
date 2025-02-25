Extension { #name : #Z3Sort }

{ #category : #'*PLE' }
Z3Sort >> matchSorts: s2 [ 
	self = s2 ifFalse: [ self shouldBeImplemented ].
	^#()
]
