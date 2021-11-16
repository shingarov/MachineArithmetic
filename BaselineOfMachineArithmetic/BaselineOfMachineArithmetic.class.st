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
				package: #'MachineArithmetic-MathNotation-Pharo';
				package: #'MachineArithmetic-MathNotation' with: [spec requires: 'MachineArithmetic-MathNotation-Pharo'];
				package: #'MachineArithmetic-FFI-Pharo';
				package: #'MachineArithmetic' with: [spec requires: 'MachineArithmetic-FFI-Pharo'];
				package: #'MachineArithmetic-Tests' with: [spec requires: 'MachineArithmetic'].
			]
]
