Class {
	#name : #DecidableRefinement,
	#superclass : #Expr,
	#instVars : [
		'tree'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
DecidableRefinement class >> always [
	^self text: 'Bool true'
]

{ #category : #'instance creation' }
DecidableRefinement class >> never [
	^self text: 'Bool false'
]

{ #category : #'instance creation' }
DecidableRefinement class >> text: aString [
	| tree |

	tree := DecidableRefinementExpressionParser parse: aString readStream.
	^self tree: tree.
]

{ #category : #'instance creation' }
DecidableRefinement class >> tree: anRBSequenceNode [
	^self basicNew tree: anRBSequenceNode
]

{ #category : #comparing }
DecidableRefinement >> = another [
	self class = another class ifFalse: [ ^false ].
	^tree = another text
]

{ #category : #visiting }
DecidableRefinement >> accept: aVisitor [ 
	^self
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> evaluateIn: anEvalEnv [
	^self evaluateIn: anEvalEnv ifUndeclared: [ :ex | ex signal ]
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> evaluateIn: anEvalEnv ifUndeclared: vndBlock [
	^[anEvalEnv evaluate: self text]
		on: VariableNotDeclared do: vndBlock
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> evaluateInventivelyIn: anEvalEnv [ 
	^self
		evaluateIn: anEvalEnv
		ifUndeclared: [ :ex |
				| varName var |
				varName := ex variableNode name.
				var := Cosa named: varName.
				self evaluateInventivelyIn: (anEvalEnv amendedBy: (Dictionary newFromAssociations: {varName->var}) ) ]
]

{ #category : #comparing }
DecidableRefinement >> hash [
	^tree hash
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> kvarsExpr [
	^#()
]

{ #category : #printing }
DecidableRefinement >> printOn: aStream [ 
	aStream
		nextPut: $«;
		nextPutAll: self text;
		nextPut: $»
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> pruneTauts [
	^self
]

{ #category : #'term rewriting' }
DecidableRefinement >> subst: su [
	^DelayedSubst subst: su in: self
]

{ #category : #'term rewriting' }
DecidableRefinement >> substPred: oldToNewVarNameAssocs [
	^self subst: (Subst mkSubstNameToName: oldToNewVarNameAssocs)
]

{ #category : #accessing }
DecidableRefinement >> text [
	^ tree formattedCode
]

{ #category : #accessing }
DecidableRefinement >> tree [
	^ tree
]

{ #category : #initialization }
DecidableRefinement >> tree: anRBSequenceNode [
	tree := anRBSequenceNode
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> uniq1: α [
	^self
]

{ #category : #private }
DecidableRefinement >> uniqAbsRefsUsing: aDictionary [
	self tree variableNodes do:[:node|
		| name |
		
		name := node name.
		name := aDictionary at: name ifAbsent:[name].
		node name: name.
	]
]

{ #category : #'well-formedness' }
DecidableRefinement >> wfIn: gamma [
self shouldBeImplemented "true if self is a bool-(unrefined-)typed formula"
]
