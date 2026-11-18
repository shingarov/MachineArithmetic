"
I represent a program in the Enriched Metalanguage.
"
Class {
	#name : #Prog,
	#superclass : #CoreProg,
	#category : #Metalanguage
}

{ #category : #construction }
Prog >> , another [
	| expr′ |
	expr isLet ifTrue:[
		| last |

		expr′:= expr copy.
		last := expr′.
		[ last isLet and: [ last expr isLet ]] whileTrue:[last := last expr].
		last expr: another expr.
	] ifFalse:[
		expr′ := another expr.
	].

	^self class
				quals: self quals , another quals
				meas: self meas , another meas
				expr: expr′
				data: self data , another data
				options: self options asSet , another options

]

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
		display: [ self uniq2 core spriteString ]
]
