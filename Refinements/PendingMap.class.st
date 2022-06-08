Class {
	#name : #PendingMap,
	#superclass : #Dictionary,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
PendingMap >> addPend: subcId [ 
	"Nondestructively add subcId.
	addPend :: CMap () -> F.SubcId -> CMap ()"
	^self copy
		at: subcId put: nil;
		yourself
]

{ #category : #'Pending API' }
PendingMap >> addPends: subcIds [
	"addPends :: CMap () -> [F.SubcId] -> CMap ()"
	^subcIds inject: self into: [ :soFar :thisSubcId | soFar addPend: thisSubcId ]
]
