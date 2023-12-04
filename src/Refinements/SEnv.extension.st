Extension { #name : #SEnv }

{ #category : #'*Refinements' }
SEnv >> lookupSEnvWithDistance: key [
	^Found x: (self at: key ifAbsent: [ ^Alts shouldBeImplemented  ])

]
