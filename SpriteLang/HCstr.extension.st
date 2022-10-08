Extension { #name : #HCstr }

{ #category : #'*SpriteLang' }
HCstr class >> subs: coll1 _: coll2 [
	coll1 size = coll2 size ifFalse: [ self error ].
	coll1 isEmpty ifTrue: [ ^self cTrue ].
	
	
	self shouldBeImplemented  
]
