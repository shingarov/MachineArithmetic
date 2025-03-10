Class {
	#name : #HOptRewrite,
	#superclass : #HOpt,
	#category : #'Refinements-Horn'
}

{ #category : #construction }
HOptRewrite >> addToOptions: options [
	options rewriteAxioms: self
]
