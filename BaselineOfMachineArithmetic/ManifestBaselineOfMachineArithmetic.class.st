"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestBaselineOfMachineArithmetic,
	#superclass : #PackageManifest,
	#category : #'BaselineOfMachineArithmetic-Manifest'
}

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

{ #category : #'stx - description' }
ManifestBaselineOfMachineArithmetic class >> referencedPreRequisites [
	"list packages which are a prerequisite, because they contain
	 classes which are referenced by my classes.
	 These packages are NOT needed as a prerequisite for compiling or loading,
	 however, a class from it may be referenced during execution and having it
	 unloaded then may lead to a runtime doesNotUnderstand error, unless the caller
	 includes explicit checks for the package being present.
	 This method is generated automatically,
	 by searching all classes (and their packages) which are referenced by my classes.
	 Please also take a look at the #mandatoryPreRequisites method"

	^ #(
		#'MachineArithmetic-FFI-SmalltalkX'
		#'MachineArithmetic'
		#'MachineArithmetic-Tests'
	)
]
