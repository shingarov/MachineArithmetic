"
I represent a program in the Enriched Metalanguage.
"
Class {
	#name : #Prog,
	#superclass : #CoreProg,
	#category : #Metalanguage
}

{ #category : #'reduction to core' }
Prog >> core [
	| mif anf exprWithInlinedNonrecursiveReflects |
	mif := [expr toMIF] runReader: #tempVarNo initialState: {0}.
	anf := mif toANF.
	exprWithInlinedNonrecursiveReflects := anf inlineNonRecursiveReflects.
	^CoreProg
		quals: quals
		meas: meas
		expr: exprWithInlinedNonrecursiveReflects
		data: data
		options: options
]
