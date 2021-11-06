Class {
	#name : #CombinedEnv,
	#superclass : #Object,
	#instVars : [
		'ci',
		'bEnv',
		'iEnv',
		'bindingsInSmt'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'as yet unclassified' }
CombinedEnv >> apply: aSolution bs: anIBindEnv [ 
"
    -- Clear the 'known' bindings for applyKVars, since it depends on
    -- using the fully expanded representation of the predicates to bind their
    -- variables with quantifiers.
    (pks, kI)     = applyKVars g {ceBindingsInSmt = F.emptyIBindEnv} s ks
    (ps,  ks, _)  = envConcKVars g s bs
"
	| preds |
	preds := anIBindEnv indexes collect: [ :i |
		(Dictionary newFromAssociations: bindingsInSmt) at: i ].
	^Bool and: preds asArray 
]

{ #category : #accessing }
CombinedEnv >> bEnv [
	^ bEnv
]

{ #category : #accessing }
CombinedEnv >> bEnv: anObject [
	bEnv := anObject
]

{ #category : #accessing }
CombinedEnv >> bindingsInSmt [
	^ bindingsInSmt
]

{ #category : #accessing }
CombinedEnv >> bindingsInSmt: anObject [
	bindingsInSmt := anObject
]

{ #category : #accessing }
CombinedEnv >> ci [
	^ ci
]

{ #category : #accessing }
CombinedEnv >> ci: anObject [
	ci := anObject
]

{ #category : #accessing }
CombinedEnv >> iEnv [
	^ iEnv
]

{ #category : #accessing }
CombinedEnv >> iEnv: anObject [
	iEnv := anObject
]
