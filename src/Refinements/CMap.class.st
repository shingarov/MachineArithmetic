"
type CMap a  = M.HashMap SubcId a

Cf. Types/Solutions.hs
"
Class {
	#name : #CMap,
	#superclass : #Dictionary,
	#category : #'Refinements-Solutions'
}

{ #category : #Worklist }
CMap >> addPend: subcId [ 
"
addPend :: CMap () -> F.SubcId -> CMap ()

Cf. Solver/Worklist.hs
"
	^self copy
		at: subcId put: nil;
		yourself
]

{ #category : #Worklist }
CMap >> addPends: subcIds [
"
addPends :: CMap () -> [F.SubcId] -> CMap ()

Cf. Solver/Worklist.hs
"
	^subcIds inject: self into: [ :soFar :thisSubcId | soFar addPend: thisSubcId ]
]
