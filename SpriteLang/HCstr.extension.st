Extension { #name : #HCstr }

{ #category : #'*SpriteLang' }
HCstr class >> subs: coll1 _: coll2 [
	| t1 t1s t2 t2s |	
	coll1 size = coll2 size ifFalse: [ self error ].
	coll1 isEmpty ifTrue: [ ^self cTrue ].
	
	t1 := coll1 first. t1s := coll1 allButFirst.
	t2 := coll2 first. t2s := coll2 allButFirst.
	t1s isEmpty ifFalse: [ self shouldBeImplemented ].
	^t1 ≺ t2 "BOGUS, implement the previous line by zipping the collection using ≺"
]
