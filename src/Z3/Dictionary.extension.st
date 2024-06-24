Extension { #name : #Dictionary }

{ #category : #'*Z3' }
Dictionary >> toZ3ParameterSet [
	| pset |

	pset := Z3ParameterSet new.
	self keysAndValuesDo: [ :key :val|
		pset at: key put: val.
	].
	^ pset.

	"Created: / 24-06-2024 / 17:15:39 / Jan Vrany <jan.vrany@labware.com>"
]
