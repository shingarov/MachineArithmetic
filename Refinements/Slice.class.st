"
slKVarCs :: [F.SubcId]     -- ^ F.SubcIds that transitively ""reach"" below
slConcCs :: [F.SubcId]     -- ^ F.SubcIds with Concrete RHS
slEdges  :: [DepEdge] -- ^ Dependencies between slKVarCs
"
Class {
	#name : #Slice,
	#superclass : #Object,
	#instVars : [
		'kVarCs',
		'concCs',
		'edges'
	],
	#category : #Refinements
}

{ #category : #accessing }
Slice >> concCs [
	^ concCs
]

{ #category : #accessing }
Slice >> concCs: anObject [
	concCs := anObject
]

{ #category : #accessing }
Slice >> edges [
	^ edges
]

{ #category : #accessing }
Slice >> edges: anObject [
	edges := anObject
]

{ #category : #accessing }
Slice >> kVarCs [
	^ kVarCs
]

{ #category : #accessing }
Slice >> kVarCs: anObject [
	kVarCs := anObject
]
