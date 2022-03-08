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
				package:#'PreSmalltalks-Pharo';
				package: #'PreSmalltalks' with:
					[spec requires: 'PreSmalltalks-Pharo'];
				package: #'PreSmalltalks-Tests' with:
					[spec requires: 'PreSmalltalks'];

				package: #'MachineArithmetic-MathNotation-Pharo' with:
					[spec requires: 'MachineArithmetic'];

				package: #'MachineArithmetic-MathNotation' with:
					[spec requires: 'MachineArithmetic-MathNotation-Pharo'];

				package: #'MachineArithmetic-FFI-Pharo';

				package: #'MachineArithmetic' with:
					[
					spec requires: 'PreSmalltalks'.
					spec requires: 'MachineArithmetic-FFI-Pharo'];

				package: #'MachineArithmetic-Tests' with:
					[spec requires: 'MachineArithmetic'];

				package: #'DepthFirstSearch' with:
					[spec requires: 'PreSmalltalks'];

				package: #'DepthFirstSearch-Tests' with:
					[spec requires: 'DepthFirstSearch'];

				package: #'Refinements' with:
					[
					spec requires: 'PreSmalltalks'.
					spec requires: 'DepthFirstSearch'.
					spec requires: 'MachineArithmetic'];

				package: #'Refinements-Parsing' with:
					[
					spec requires: 'PetitParser'.
					spec requires: 'Refinements'];

				package: #'Refinements-Tests' with:
					[spec requires: 'Refinements-Parsing'] ];
			
		for: #GToolkit do: [ spec package: #'DepthFirstSearch-GT' with: [ spec requires: 'DepthFirstSearch' ] ]


]
