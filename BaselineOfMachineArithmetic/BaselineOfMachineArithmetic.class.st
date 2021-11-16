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
			spec baseline: 'PetitParser' with: [
				spec loads: 'Core'.
				spec loads: 'Analyzer'.
				"
				HACK: We have to use forked PetitParser with XInclude processing
				support forward-ported. This is not used by ArchC, but it *IS*
				used by ULD and we intend to use ULD.

				There are better ways to deal with this but no time now.
				"
				"spec repository: 'github://moosetechnology/PetitParser'"
				spec repository: 'github://shingarov/PetitParser:ULD'
			].

			spec
				package: #'MachineArithmetic-MathNotation-Pharo';
				package: #'MachineArithmetic-MathNotation' with: [spec requires: 'MachineArithmetic-MathNotation-Pharo'];
				package: #'MachineArithmetic-FFI-Pharo';
				package: #'MachineArithmetic' with: 
					[spec requires: 'MachineArithmetic-FFI-Pharo'.
					spec requires: 'PetitParser'];
				package: #'MachineArithmetic-Tests' with: [spec requires: 'MachineArithmetic'].
			]
]
