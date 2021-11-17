Class {
	#name : #SimpC,
	#superclass : #AbstractC,
	#instVars : [
		'bindId'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #logic }
SimpC >> clhs: be [
	self shouldBeImplemented "cf. Constraints.hs"
]

{ #category : #logic }
SimpC >> crhs [
	^rhs
]

{ #category : #'as yet unclassified' }
SimpC >> initializeFrom: subc bindm: m [
	env := subc env.
	rhs := subc rhs sr_reft expr.
	id := subc id.
	bindId := m at: subc id


]

{ #category : #'as yet unclassified' }
SimpC >> mapKVarSubsts: aBlock [
	rhs := rhs mapKVarSubsts: aBlock.
	^self
]

{ #category : #GT }
SimpC >> textForGT_subclassSpecific [
	^'bindId: ', bindId printString, String cr
]

{ #category : #GT }
SimpC >> textTabLabel [
	^'Simple constraint'
]
