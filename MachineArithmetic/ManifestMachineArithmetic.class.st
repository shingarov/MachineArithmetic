"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestMachineArithmetic,
	#superclass : #PackageManifest,
	#category : #'MachineArithmetic-Manifest'
}

{ #category : #'code-critics' }
ManifestMachineArithmetic class >> ruleRBRefersToClassRuleV1FalsePositive [
	^ #(#(#(#RGMetaclassDefinition #(#'P class' #P)) #'2019-07-13T14:10:33.353195-04:00') )
]
