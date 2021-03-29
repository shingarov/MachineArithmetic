Class {
	#name : #BaselineOfMachineArithmetic,
	#superclass : #BaselineOf,
	#category : #BaselineOfMachineArithmetic
}

{ #category : #baselines }
BaselineOfMachineArithmetic >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do: [
			spec baseline: 'PyGate' with: [
				spec repository: 'github://shingarov/PyGate:ghost'
			].
			spec
				package: #'MachineArithmetic'.
			]
]
