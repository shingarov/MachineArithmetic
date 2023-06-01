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

			spec postLoadDoIt: #postLoad:spec:.

			"Due to changes in primitive numbers between Pharo 8 and Pharo 9,
			 we need to use different overrides for perform:..."
			SystemVersion current major <= 8
				ifTrue: [currySupportPackage := 'PreSmalltalks-Pharo8-Curry']
				ifFalse:[currySupportPackage := 'PreSmalltalks-Pharo-Curry'].

			"Pharo 10 removed built-in support for #mustBeBoolean deoptimization
			 (see [1]). Therefore we have to load a package to bring it back.

			 [1]: https://github.com/pharo-project/pharo/commit/94cff3ad2fbd38eeb9231e4dd5c2894379f2849d
			"
			SystemVersion current major >= 10 ifTrue: [
				"If the package ever changes, #postLoad:spec: method *must*
				 be updated accordingly!"
				spec package: #'MustBeBooleanMagic'.
				spec package: #'PreSmalltalks-Pharo' with: [
					spec requires: #'MustBeBooleanMagic'
				].
			].

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
				package:currySupportPackage;
				package:#'PreSmalltalks-Applicative';
				package:#'PreSmalltalks-Substitutions';
				package: #'PreSmalltalks' with:
					[spec requires: 'PreSmalltalks-Pharo';
						  requires: currySupportPackage;
						  requires: 'PreSmalltalks-Applicative';
					      requires: 'PreSmalltalks-Substitutions'
					];
				package: #'PreSmalltalks-Tests' with:
					[spec requires: 'PreSmalltalks'];

				package:#'CardanoTartaglia';
				package: #'CardanoTartaglia-Tests' with:
					[spec requires: 'CardanoTartaglia'];

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
					spec requires: 'CardanoTartaglia'.
					spec requires: 'DepthFirstSearch'.
					spec requires: 'MachineArithmetic'];

				package: #'Refinements-Parsing' with:
					[
					spec requires: 'PetitParser'.
					spec requires: 'Refinements'];

				package: #'Refinements-Tests' with:
					[spec requires: 'Refinements-Parsing'];

				package: #'Refinements-Doodles' with:
					[spec requires: 'Refinements-Parsing'];

				package: #'SpriteLang' with:
					[spec requires: 'Refinements'];

				package: #'SpriteLang-Tests' with:
					[spec requires: 'SpriteLang'].

			"Groups"
			spec
				group: 'Z3only' with: #('PreSmalltalks'
										'MachineArithmetic-FFI-Pharo'
										'MachineArithmetic'
										'MachineArithmetic-Tests').
		].

	spec
		for: #GToolkit
		do: [
			spec package: #'DepthFirstSearch-GT' with:
				[ spec requires: 'DepthFirstSearch' ].
		].

]

{ #category : #actions }
BaselineOfMachineArithmetic >> postLoad: loader spec: spec [
	"Load #mustBeBoolean deoptimization support if needed (see comment above)"
	SystemVersion current major >= 10 ifTrue: [
		#NonBooleanReceiver asClass mustBeBooleanHandler: #MBBMagic asClass new
	]
]