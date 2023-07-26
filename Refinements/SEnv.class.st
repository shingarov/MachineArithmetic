Class {
	#name : #SEnv,
	#superclass : #Dictionary,
	#category : #Refinements
}

{ #category : #environments }
SEnv >> at: x insert: v [
"
insertSEnv :: Symbol -> a -> SEnv a -> SEnv a
insertSEnv x v (SE env) = SE (M.insert x v env)
"
	^self copy
		at: x put: v;
		yourself
]

{ #category : #environments }
SEnv >> deleteSEnv: x [
"
deleteSEnv :: Symbol -> SEnv a -> SEnv a
deleteSEnv x (SE env)   = SE (M.delete x env)
"
	^self withoutKeys: {x}
]

{ #category : #'*Refinements' }
SEnv >> lookupSEnvWithDistance: key [
	^Found x: (self at: key ifAbsent: [ ^Alts shouldBeImplemented  ])

]
