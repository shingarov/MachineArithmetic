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
			spec
				package: #'MachineArithmetic-MathNotation';
				package: #'MachineArithmetic-MathNotation-Pharo';
				package: #'MachineArithmetic-FFI-Pharo';
				package: #'MachineArithmetic';
				package: #'MachineArithmetic-Tests'.
			]
]
