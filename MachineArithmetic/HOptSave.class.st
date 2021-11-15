Class {
	#name : #HOptSave,
	#superclass : #HOpt,
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #construction }
HOptSave >> addToQuery: aNNFQuery [ 
	aNNFQuery options save: self
]
