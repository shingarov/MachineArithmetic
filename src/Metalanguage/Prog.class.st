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

{ #category : #GT }
Prog >> gtInspectorSpriteOfCoreIn: composite [
	<gtInspectorPresentationOrder: 55>

	^composite text
		title: 'Source (core program)';
		display: [ self core spriteString ]
]
