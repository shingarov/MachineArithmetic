Class {
	#name : #DecidableRefinement,
	#superclass : #Expr,
	#instVars : [
		'text'
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
DecidableRefinement class >> text: t [
	^self basicNew 
		text: t;
		yourself 
]

{ #category : #comparing }
DecidableRefinement >> = another [
	self class = another class ifFalse: [ ^false ].
	^text = another text
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
				self evaluateIn: (anEvalEnv amendedBy: (Dictionary newFromAssociations: {varName->var}) ) ]
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> findKVarInGuard: k [ 
	^Either right: self
]

{ #category : #comparing }
DecidableRefinement >> hash [
	^text hash
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> isKVar [ 
	^false
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
	^ text
]

{ #category : #accessing }
DecidableRefinement >> text: anObject [
	text := anObject
]

{ #category : #'as yet unclassified' }
DecidableRefinement >> uniq1: α [
	^self
]

{ #category : #'well-formedness' }
DecidableRefinement >> wfIn: gamma [
self shouldBeImplemented "true if self is a bool-(unrefined-)typed formula"
]
