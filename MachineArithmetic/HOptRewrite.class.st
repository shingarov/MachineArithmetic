Class {
	#name : #HOptRewrite,
	#superclass : #HOpt,
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #construction }
HOptRewrite >> addToQuery: aNNFQuery [ 
	aNNFQuery options rewrite: self
]
