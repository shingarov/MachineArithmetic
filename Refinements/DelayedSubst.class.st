Class {
	#name : #DelayedSubst,
	#superclass : #HPred,
	#instVars : [
		'substitutions',
		'expression'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
DelayedSubst class >> from: old to: new in: anExpression [
	| dict |
	dict := Dictionary newFromAssociations: { old->new. }.
	^self subst: dict in: anExpression
]

{ #category : #'as yet unclassified' }
DelayedSubst class >> subst: substitutions in: anExpression [
	^self basicNew
			substitutions: substitutions;
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
	^(self expression evaluateIn: aBindEnv) inEnvironment: (self substitutionEnvironmentOver: aBindEnv)
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
DelayedSubst >> rename: a to: b renamer: α [ 
	self shouldBeImplemented.
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
	assocs := (substitutions isKindOf: Subst)
		ifTrue: [ substitutions list ]
		ifFalse: [ substitutions associations ].
	
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
	^self
]
