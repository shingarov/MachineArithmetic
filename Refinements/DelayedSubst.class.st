Class {
	#name : #DelayedSubst,
	#superclass : #HPred,
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
(aSubst isKindOf: Subst) ifFalse: [ self error ].
	^self basicNew
			substitutions: aSubst;
			expression: anExpression;
			yourself
]

{ #category : #comparing }
DelayedSubst >> = another [
	self class = another class ifFalse: [ ^false ].
	expression = another expression ifFalse: [ ^false ].
	^substitutions = another substitutions
]

{ #category : #'as yet unclassified' }
DelayedSubst >> boundKVars [
	^#()
]

{ #category : #'term rewriting' }
DelayedSubst >> evaluateIn: aBindEnv [
	| amendedBE |
	substitutions evaluateIn: aBindEnv. "make sure everything has been compiled"
	amendedBE := substitutions amend: aBindEnv. "dirty hack to allow the decidable ref to compile"
	^substitutions applyTo: (self expression evaluateIn: amendedBE)
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
DelayedSubst >> isTauto [
	^expression isTauto
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

{ #category : #'term rewriting' }
DelayedSubst >> rename: a to: b [
	^DelayedSubst from: a toVar: b in: expression
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

{ #category : #'as yet unclassified' }
DelayedSubst >> uniq1: α [
	"COMPLETELY BOGUS"
	^self "halt"
]
