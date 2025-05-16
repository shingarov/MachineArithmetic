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
	| exprWithInlinedNonrecursiveReflects mifExpr |
	exprWithInlinedNonrecursiveReflects := expr inlineNonRecursiveReflects.
	mifExpr := [exprWithInlinedNonrecursiveReflects toMIF] runReader: #tempVarNo initialState: {0}.
	^CoreProg
		quals: quals
		meas: meas
		expr: mifExpr toANF
		data: data
		options: options
]
