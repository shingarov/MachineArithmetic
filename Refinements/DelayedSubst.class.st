Class {
	#name : #DelayedSubst,
	#superclass : #Expr,
	#instVars : [
		'substitutions',
		'expression'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
DelayedSubst class >> from: oldVarName toExpr: newExpr in: anExpression [
	^self
		subst: (Subst mkSubst: {oldVarName -> newExpr})
		in: anExpression
]

{ #category : #'instance creation' }
DelayedSubst class >> from: oldVarName toVar: newVarName in: anExpression [
	^self from: oldVarName toExpr: (EVar of: newVarName) in: anExpression

]

{ #category : #'instance creation' }
DelayedSubst class >> subst: aSubst in: anExpression [
	| su |
	su := aSubst  "withoutJunk".
	su isEmpty ifTrue: [ ^anExpression ].
	^self basicNew
			substitutions: su;
			expression: anExpression;
			yourself
]

{ #category : #comparing }
DelayedSubst >> = another [
	self class = another class ifFalse: [ ^false ].
	expression = another expression ifFalse: [ ^false ].
	^substitutions = another substitutions
]

{ #category : #visiting }
DelayedSubst >> accept: aVisitor [
	^self class
		subst: substitutions
		in: (expression accept: aVisitor)
]

{ #category : #'as yet unclassified' }
DelayedSubst >> boundKVars [
	^#()
]

{ #category : #'term rewriting' }
DelayedSubst >> evaluateIn: anEvalEnv [
	| evaluatedSubstitutions amendedEvalEnv |
	evaluatedSubstitutions := substitutions evaluateIn: anEvalEnv.
	amendedEvalEnv := anEvalEnv amendedBy: evaluatedSubstitutions.
	^expression evaluateIn: amendedEvalEnv
]

{ #category : #accessing }
DelayedSubst >> expression [
	^ expression
]

{ #category : #accessing }
DelayedSubst >> expression: anObject [
	expression := anObject
]

{ #category : #comparing }
DelayedSubst >> hash [
	^expression hash
]

{ #category : #'as yet unclassified' }
DelayedSubst >> isKVar [
	^false
]

{ #category : #'as yet unclassified' }
DelayedSubst >> kvarsExpr [
	"BOGUS: Please do something!"
	^#()
]

{ #category : #printing }
DelayedSubst >> printOn: aStream [
	expression printOn: aStream.
	substitutions printOn: aStream.
]

{ #category : #'as yet unclassified' }
DelayedSubst >> pruneTauts [
	^DelayedSubst subst: substitutions in: expression pruneTauts
]

{ #category : #'as yet unclassified' }
DelayedSubst >> subst: su [
	^DelayedSubst subst: su in: self
]

{ #category : #'as yet unclassified' }
DelayedSubst >> substPred: oldToNewVarNameAssocs [
	^self subst: (Subst mkSubstNameToName: oldToNewVarNameAssocs)
]

{ #category : #'as yet unclassified' }
DelayedSubst >> substitutionEnvironment [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
DelayedSubst >> substitutionEnvironmentOver: aBindEnv [
	| assocs substs |
	
	"BOGUS!!!
	at times my substitutions are a Dictionary(String->String),
	but sometimes are an instance of Subst.  This needs to homogenize."
	(substitutions isKindOf: Subst) ifFalse: [ self error ].
	
		
	
	substs := assocs collect: [ :ass |
			(aBindEnv ctContext tempNamed: ass key) -> (aBindEnv evaluate: ass value)].
		^Dictionary newFromAssociations: substs
]

{ #category : #accessing }
DelayedSubst >> substitutions [
	^ substitutions
]

{ #category : #accessing }
DelayedSubst >> substitutions: anObject [
	substitutions := anObject
]
