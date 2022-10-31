"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestBaselineOfMachineArithmetic,
	#superclass : #PackageManifest,
	#category : #'BaselineOfMachineArithmetic-Manifest'
}

{ #category : #'stx - description' }
ManifestBaselineOfMachineArithmetic class >> includedInPreRequisites [
	"list packages which are to be implicitely included in the prerequisites list,
	 even if not found by the automatic search.
	 Redefine this, if classes from other packages are referred to via reflection
	 or by constructing names dynamically (i.e. the search cannot find it)"  

	^ #(
		#'PreSmalltalks'
		#'PreSmalltalks-Tests'
		#'MachineArithmetic-FFI-SmalltalkX'
		#'MachineArithmetic'
		#'MachineArithmetic-Tests'
	)
]

{ #category : #'stx - description' }
ManifestBaselineOfMachineArithmetic class >> mandatoryPreRequisites [
	"list packages which are mandatory as a prerequisite.
	 This are packages containing superclasses of my classes and classes which
	 are extended by myself.
	 They are mandatory, because we need these packages as a prerequisite for loading and compiling.
	 This method is generated automatically,
	 by searching along the inheritance chain of all of my classes.
	 Please take a look at the #referencedPreRequisites method as well."

	^ #(
		#'stx:libbasic'
		#'stx:libcompat'    "PackageManifest - superclass of BaselineOfMachineArithmetic"
	)
]

{ #category : #'stx - description - actions' }
ManifestBaselineOfMachineArithmetic class >> preLoadAction [
	ParserFlags allowGreekCharactersInIdentifier: true.
]
