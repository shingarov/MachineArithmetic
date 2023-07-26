"
API for manipulating Sort Substitutions
newtype TVSubst = Th (M.HashMap Int Sort)
Cf. SortCheck.hs
"
Class {
	#name : #TVSubst,
	#superclass : #Dictionary,
	#category : #Refinements
}

{ #category : #API }
TVSubst >> applyTo: aSort [
"
apply :: TVSubst -> Sort -> Sort
"
	^aSort mapSort: [ :t |
		(t isKindOf: FVar) ifTrue: [ self at: t i  ifAbsent: [t] ]
			ifFalse: [ t ]
	]
]

{ #category : #API }
TVSubst >> lookupVar: i [
"
lookupVar :: Int -> TVSubst -> Maybe Sort
"
	^self at: i ifAbsent: [ ^nil ]
]

{ #category : #API }
TVSubst >> updateVar: i _: t [
"
updateVar :: Int -> Sort -> TVSubst -> TVSubst
However, we are explicitly destructive, as opposed to ReaderT
"
	^self
		at: i put: t;
		yourself
]
