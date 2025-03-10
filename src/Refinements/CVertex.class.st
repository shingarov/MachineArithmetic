"
data CVertex = KVar  !KVar    -- ^ real kvar vertex
             | DKVar !KVar    -- ^ dummy to ensure each kvar has a successor
             | EBind !F.Symbol  -- ^ existentially bound ""ghost paramter"" to solve for
             | Cstr  !Integer -- ^ constraint-id which creates a dependency
               deriving (Eq, Ord, Show, Generic)
Cf. Graph/Types.hs
"
Class {
	#name : #CVertex,
	#superclass : #Object,
	#category : #'Refinements-Graph'
}

{ #category : #'as yet unclassified' }
CVertex >> <= anotherVertex [ 
	^self printString, self hash printString <= (anotherVertex printString, anotherVertex hash printString)
]

{ #category : #testing }
CVertex >> isCstr [
	^false
]

{ #category : #testing }
CVertex >> isKVar [
	^false
]
