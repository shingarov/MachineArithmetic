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
			| currySupportPackage |


			"Due to changes in primitive numbers between Pharo 8 and Pharo 9,
			 we need to use different overrides for perform:..."
			SystemVersion current major <= 8
				ifTrue: [currySupportPackage := 'PreSmalltalks-Pharo8-Curry']
				ifFalse:[currySupportPackage := 'PreSmalltalks-Pharo-Curry'].

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
				package:#'PreSmalltalks-FxEncoding';
				package: #'PreSmalltalks' with:
					[spec requires:{ 'PreSmalltalks-Pharo' .
					                  currySupportPackage .
					                 'PreSmalltalks-Applicative' .
					                 'PreSmalltalks-Substitutions' .
					                 'PreSmalltalks-ZEncoding' .
					                 'PreSmalltalks-FxEncoding'}.
					];
				package: #'PreSmalltalks-Parser' with:
					[spec requires:#('PreSmalltalks'
					                 'PetitParser').
					];
				package: #'PreSmalltalks-Tests' with:
					[spec requires:#('PreSmalltalks'
					                 'PreSmalltalks-Parser').
					];

				package:#'CardanoTartaglia';
				package: #'CardanoTartaglia-Tests' with:
					[spec requires: 'CardanoTartaglia'];

				package: #'Collections-Homogeneous' with:
					[spec requires: 'Z3'];

				package: #'Collections-Homogeneous-Tests' with:
					[spec requires: 'Collections-Homogeneous'];

				package: #'MathNotation-Pharo' with:
					[spec requires:#('Z3'
					                 'Collections-Homogeneous').
					];

				package: #'MathNotation' with:
					[spec requires: 'MathNotation-Pharo'];

				package: #'Z3-FFI-Pharo';

				package: #'Z3' with:
					[
					spec requires:#('PreSmalltalks'
					                'Z3-FFI-Pharo').];

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
					spec requires: #('PreSmalltalks'
					                 'CardanoTartaglia'
					                 'DepthFirstSearch'
					                 'Z3'
					                 'MathNotation').];

				package: #'PetitSmalltalk' with:
					[
					spec requires: 'PetitParser'.
					spec repository: 'github://shingarov/PetitParser:ULD'];

				package: #'Refinements-Parsing' with:
					[
					spec requires: #('PetitParser'
					                 'PetitSmalltalk'
					                 'PreSmalltalks-Parser'
					                 'Refinements').];

				package: #'Refinements-Tests' with:
					[spec requires:#('PreSmalltalks-Tests'
					                 'Refinements-Parsing'
					                 'PLE').];

				package: #'Refinements-Doodles' with:
					[spec requires:#('Refinements-Parsing'
					                 'Refinements-Tests')
					];

				package: #'SpriteLang' with:
					[
					spec requires: 'Refinements-Parsing'];

				package: #'SpriteLang-Tests' with:
					[spec requires: 'SpriteLang'];

				package: #'PLE' with:
					[spec requires:#('Refinements'
					                 'SpriteLang').];

				package: #'PLE-Tests' with:
					[spec requires: 'PLE'];

				package: #'Metalanguage' with:
					[spec requires: 'SpriteLang'];

				package: #'Metalanguage-Tests' with:
					[spec requires:#('Metalanguage'
					                 'SpriteLang-Tests').];

				yourself.

			"Groups"
			spec group: 'Z3Proper' with: #(
				'Z3'
				'Z3-Tests'
			).
			spec group: 'Full' with: #(
				'Z3Proper'

				'MathNotation'
				'Refinements'
				'SpriteLang'
				'Metalanguage'
				'PLE'

				'PreSmalltalks-Tests'
				'Z3-Tests'
				'MathNotation-Tests'
				'Refinements-Tests'
				'SpriteLang-Tests'
				'PLE-Tests'
				'Metalanguage-Tests'
				'Collections-Homogeneous-Tests'
			).

			"Group aliases"
			spec group: 'default' with: #('Full').
			spec group: 'Z3only'  with: #('Z3Proper').

		].

	spec
		for: #GToolkit
		do: [
			spec package: #'DepthFirstSearch-GT' with:
				[ spec requires: 'DepthFirstSearch' ].
		].

]