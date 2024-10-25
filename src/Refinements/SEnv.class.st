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

{ #category : #'as yet unclassified' }
SEnv >> freezeNaturalTransformationsIn: aSymEnv [ 
	self keysAndValuesDo: [ :funcName :α | self at: funcName put: (α freezeIn: aSymEnv) ]
]

{ #category : #environments }
SEnv >> lookupSEnv: x [
"
lookupSEnv :: Symbol -> SEnv a -> Maybe a
lookupSEnv x (SE env)   = M.lookup x env
"
	^self at: x ifAbsent: [ nil ]
]

{ #category : #'*Refinements' }
SEnv >> lookupSEnvWithDistance: key [
	^Found x: (self at: key ifAbsent: [ ^Alts shouldBeImplemented  ])

]

{ #category : #'SMT interface' }
SEnv >> symbolSorts [
"
symbolSorts :: F.SEnv F.Sort -> [(F.Symbol, F.Sort)]
Cf. Smt/Interface.hs
Note that this is not the same as Solver.Sanitize.symbolSorts!
"
	^self associations collectAssociations: [ :x :t | x -> (t maybeExistingSortIn: self) ]
]
