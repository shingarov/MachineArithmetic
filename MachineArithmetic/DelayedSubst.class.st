Class {
	#name : #DelayedSubst,
	#superclass : #HPred,
	#instVars : [
		'substitutions',
		'expression'
	],
	#category : #'MachineArithmetic-Refinement'
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
DelayedSubst >> evaluateIn: aBindEnv [
	| substs |
	substs := self substitutions associations collect: [ :ass |
		(aBindEnv variableNamed: ass key) -> (aBindEnv evaluate: ass value)].
	^(self expression evaluateIn: aBindEnv) inEnvironment: (Dictionary newFromAssociations: substs)
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

{ #category : #printing }
DelayedSubst >> printOn: aStream [
	expression printOn: aStream.
	aStream nextPut: $[.
	self printSubstitutionsOn: aStream.
	aStream nextPut: $].
]

{ #category : #printing }
DelayedSubst >> printSubstitutionsOn: aStream [
	self substitutions associations
		do: [ :oneSubst |
			aStream nextPutAll: oneSubst value asString;
				nextPut: $/;
				nextPutAll: oneSubst key asString ]
		separatedBy: [ aStream nextPutAll: ', ' ]
]

{ #category : #accessing }
DelayedSubst >> substitutions [
	^ substitutions
]

{ #category : #accessing }
DelayedSubst >> substitutions: anObject [
	substitutions := anObject
]
