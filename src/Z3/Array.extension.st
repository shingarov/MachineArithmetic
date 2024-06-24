Extension { #name : #Array }

{ #category : #'*Z3' }
Array >> toZ3ParameterSet [
	(self allSatisfy: [:e | e isKindOf: Association"there's no isAssociation in Pharo"]) ifTrue: [
		| pset |

		pset := Z3ParameterSet new.
		self do:[:assoc|
			pset at: assoc key put: assoc value.
		].
		^ pset.
	].
	(self size \\ 2) == 0 ifTrue: [
		| pset |

		pset := Z3ParameterSet new.
		1 to: self size by: 2 do:[:i|
			pset at: (self at: i) put: (self at: i + 1).
		].
		^ pset.
	].
	self error: 'No automatic conversion to Z3 parameter set'

	"Created: / 24-06-2024 / 19:53:24 / Jan Vrany <jan.vrany@labware.com>"
]
