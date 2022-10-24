Extension { #name : #UndefinedObject }

{ #category : #'*PreSmalltalks-Substitutions' }
UndefinedObject >> subSymbol: x [
	^x
]

{ #category : #'*PreSmalltalks-Substitutions' }
UndefinedObject >> subst: _ [
	"instance Subable () where... .
	 NB: This also gives us instance Subable a => Subable (Maybe a) for free.
	"
	^self
]

{ #category : #'*PreSmalltalks-Substitutions' }
UndefinedObject >> substa: _ [
	"instance Subable () where... .
	 NB: This also gives us instance Subable a => Subable (Maybe a) for free.
	"
	^self
]

{ #category : #'*PreSmalltalks-Substitutions' }
UndefinedObject >> substf: _ [
	"instance Subable () where... .
	 NB: This also gives us instance Subable a => Subable (Maybe a) for free.
	"
	^self
]

{ #category : #'*PreSmalltalks-Substitutions' }
UndefinedObject >> syms [
	"instance Subable () where... .
	 NB: This also gives us instance Subable a => Subable (Maybe a) for free.
	"
	^#()
]
