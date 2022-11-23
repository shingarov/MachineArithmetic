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

{ #category : #'*Refinements' }
SEnv >> lookupSEnvWithDistance: key [
	^Found x: (self at: key ifAbsent: [ ^Alts shouldBeImplemented  ])

]

{ #category : #'as yet unclassified' }
SEnv >> note: preSort elaboratedTo: z3Sort [
	| varNames | "self shouldBeImplemented ." "the following is definitely wrong -- what about subexpressions?"
	varNames := self keysAtValue: preSort.
	varNames do: [ :eachVar | self at: eachVar put: z3Sort ]
]
