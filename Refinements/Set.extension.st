Extension { #name : #Set }

{ #category : #'*Refinements' }
Set >> sPop [
"this placement for this code is idiotic"
	| min |
	self isEmpty ifTrue: [ ^nil ].
	min := (self asSortedCollection: [ :a :b | a cId <= b cId ]) first.
	^min cId -> (self copy remove: min; yourself)
]
