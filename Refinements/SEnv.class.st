Class {
	#name : #SEnv,
	#superclass : #Dictionary,
	#category : #Refinements
}

{ #category : #'*Refinements' }
SEnv >> lookupSEnvWithDistance: key [
	^Found x: (self at: key ifAbsent: [ ^Alts shouldBeImplemented  ])

]

{ #category : #'as yet unclassified' }
SEnv >> note: preSort elaboratedTo: z3Sort [
	| varNames |
	varNames := self keysAtValue: preSort.
	varNames do: [ :eachVar | self at: eachVar put: z3Sort ]
]
