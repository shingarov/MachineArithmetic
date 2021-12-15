Class {
	#name : #HOptRewrite,
	#superclass : #HOpt,
	#category : #Refinements
}

{ #category : #construction }
HOptRewrite >> addToQuery: aNNFQuery [ 
	aNNFQuery options rewrite: self
]
