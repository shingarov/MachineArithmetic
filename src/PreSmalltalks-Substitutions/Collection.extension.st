Extension { #name : #Collection }

{ #category : #'*PreSmalltalks-Substitutions' }
Collection >> subst: f [
	"instance Subable a => Subable [a] where
	   subst  = fmap . subst"
	^self collect: [ :each | each subst: f ]
]

{ #category : #'*PreSmalltalks-Substitutions' }
Collection >> substa: f [
	"instance Subable a => Subable [a] where
	   substa  = fmap . substa"
	^self collect: [ :each | each substa: f ]
]

{ #category : #'*PreSmalltalks-Substitutions' }
Collection >> substf: f [
	"instance Subable a => Subable [a] where
	   substf  = fmap . substf"
	^self collect: [ :each | each substf: f ]
]

{ #category : #'*PreSmalltalks-Substitutions' }
Collection >> syms [
	"instance Subable a => Subable [a] where
	   syms   = concatMap syms"
	^self >>= #syms
]
