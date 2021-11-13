Class {
	#name : #SimpC,
	#superclass : #AbstractC,
	#instVars : [
		'bindId'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'as yet unclassified' }
SimpC >> initializeFrom: subc bindm: m [
	env := subc env.
	rhs := subc rhs sr_reft expr.
	id := subc id.
	bindId := m at: subc id


]

{ #category : #GT }
SimpC >> textForGT_subclassSpecific [
	^'bindId: ', bindId printString, String cr
]

{ #category : #GT }
SimpC >> textTabLabel [
	^'Simple constraint'
]
