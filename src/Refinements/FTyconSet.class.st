Class {
	#name : #FTyconSet,
	#superclass : #SingletonFTycon,
	#category : #Refinements
}

{ #category : #names }
FTyconSet class >> conName [
	^'Set_Set'
]

{ #category : #hotel }
FTyconSet >> smtApply: ts originalFApp: anFApp in: γ [
	ts size = 1 ifFalse: [ self error: 'Set type constructor takes exactly 1 argument' ].
	^(ts first z3sort: γ) mkSetSort
]
