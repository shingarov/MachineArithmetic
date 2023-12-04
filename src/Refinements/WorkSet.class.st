"
I am a Set of WorkItems.
"
Class {
	#name : #WorkSet,
	#superclass : #Set,
	#category : #Refinements
}

{ #category : #'Set API' }
WorkSet >> sAdds: aCollection [
	"Nondestructive addAll:
	sAdds :: WorkSet -> [WorkItem] -> WorkSet"
	^self copy 
		addAll: aCollection;
		yourself
]

{ #category : #'Set API' }
WorkSet >> sPop [
	"sPop :: WorkSet -> Maybe (F.SubcId, WorkSet)"
	| min |
	self isEmpty ifTrue: [ ^nil ].
	min := (self asSortedCollection: [ :a :b | a cId <= b cId ]) first.
	^min cId -> (self copy remove: min; yourself)
]
