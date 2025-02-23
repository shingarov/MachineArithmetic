Class {
	#name : #HOptRewrite,
	#superclass : #HOpt,
	#category : #Refinements
}

{ #category : #construction }
HOptRewrite >> addToOptions: options [
	options rewriteAxioms: self
]
