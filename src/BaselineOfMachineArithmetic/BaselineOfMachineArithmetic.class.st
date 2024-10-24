Class {
	#name : #BaselineOfMachineArithmetic,
	#superclass : #BaselineOf,
	#category : #BaselineOfMachineArithmetic
}

{ #category : #baselines }
BaselineOfMachineArithmetic >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec postLoadDoIt: #'postLoad'.
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

			"Packages"
			spec
				package:#'PreSmalltalks-Pharo';
				package:#'PreSmalltalks-Applicative';
				package:#'PreSmalltalks-Substitutions';
				package:#'PreSmalltalks-ZEncoding';
				package: #'PreSmalltalks' with:
					[spec requires: 'PreSmalltalks-Pharo';
					      requires: 'PreSmalltalks-Applicative';
					      requires: 'PreSmalltalks-Substitutions';
					      requires: 'PreSmalltalks-ZEncoding'
					];
				package: #'PreSmalltalks-Parser' with:
					[spec requires: 'PreSmalltalks';
					      requires: 'PetitParser'];
				package: #'PreSmalltalks-Tests' with:
					[spec requires: 'PreSmalltalks'];

				package:#'CardanoTartaglia';
				package: #'CardanoTartaglia-Tests' with:
					[spec requires: 'CardanoTartaglia'];

				package: #'Collections-Homogeneous' with:
					[spec requires: 'Z3'];

				package: #'Collections-Homogeneous-Tests' with:
					[spec requires: 'Collections-Homogeneous'];

				package: #'MathNotation-Pharo' with:
					[spec requires: 'Z3';
					      requires: 'Collections-Homogeneous'
					];

				package: #'MathNotation' with:
					[spec requires: 'MathNotation-Pharo'];

				package: #'Z3-FFI-Pharo';

				package: #'Z3' with:
					[
					spec requires: 'PreSmalltalks'.
					spec requires: 'Z3-FFI-Pharo'];

				package: #'Z3-Tests' with:
					[spec requires: 'Z3'];

				package: #'MathNotation-Tests' with:
					[spec requires: 'MathNotation'];

				package: #'DepthFirstSearch' with:
					[spec requires: 'PreSmalltalks'];

				package: #'DepthFirstSearch-Tests' with:
					[spec requires: 'DepthFirstSearch'];

				package: #'Refinements' with:
					[
					spec requires: 'PreSmalltalks'.
					spec requires: 'CardanoTartaglia'.
					spec requires: 'DepthFirstSearch'.
					spec requires: 'Z3'.
					spec requires: 'MathNotation'];

				package: #'PetitSmalltalk' with:
					[
					spec requires: 'PetitParser'.
					spec repository: 'github://shingarov/PetitParser:ULD'];

				package: #'Refinements-Parsing' with:
					[
					spec requires: 'PetitParser';
					     requires: 'PetitSmalltalk';
					     requires: 'PreSmalltalks-Parser';
					     requires: 'Refinements'];

				package: #'Refinements-Tests' with:
					[spec requires: 'Refinements-Parsing'.
					 spec requires: 'PLE'];

				package: #'Refinements-Doodles' with:
					[spec requires: 'Refinements-Parsing'];

				package: #'SpriteLang' with:
					[
					spec requires: 'Refinements-Parsing'];

				package: #'SpriteLang-Tests' with:
					[spec requires: 'SpriteLang'];

				package: #'PLE' with:
					[spec requires: 'Refinements'.
					 spec requires: 'SpriteLang'];

				package: #'PLE-Tests' with:
					[spec requires: 'PLE'];

				yourself.

			"Groups"
			spec
				group: 'Z3only' with: #('PreSmalltalks'
										'Z3-FFI-Pharo'
										'Z3'
										'Z3-Tests').
		].

	spec
		for: #GToolkit
		do: [
			spec package: #'DepthFirstSearch-GT' with:
				[ spec requires: 'DepthFirstSearch' ].
		].

]

{ #category : #baselines }
BaselineOfMachineArithmetic >> postLoad [
	[( Symbol >> #value: ) removeFromSystem]
		on: KeyNotFound
		do: []
]
