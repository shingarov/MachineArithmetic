Class {
	#name : #InterpretedApp,
	#superclass : #Object,
	#instVars : [
		'ts',
		'args',
		'resultSort',
		'env'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
InterpretedApp class >> ts: aTheorySymbol args: args resultSort: resultSort env: aSymEnv [
	^self basicNew
		ts: aTheorySymbol;
		args: args;
		resultSort: resultSort;
		env: aSymEnv;
		yourself
		
]

{ #category : #accessing }
InterpretedApp >> args [
	^ args
]

{ #category : #accessing }
InterpretedApp >> args: anObject [
	args := anObject
]

{ #category : #accessing }
InterpretedApp >> env [
	^ env
]

{ #category : #accessing }
InterpretedApp >> env: anObject [
	env := anObject
]

{ #category : #accessing }
InterpretedApp >> resultSort [
	^ resultSort
]

{ #category : #accessing }
InterpretedApp >> resultSort: anObject [
	resultSort := anObject
]

{ #category : #'SMT interface' }
InterpretedApp >> smt2: γ [
	| s α D αc smtD smtC smtArgs |
	s := ts tsSym.
	α := env naturalTransformations at: s.
	α isFrozen ifFalse: [ α freezeIn: γ ].
	D := args collect: #sort.
	smtD := D collect: [ :each | each z3sort: γ ].
	smtArgs := args collect: [ :eachArg | eachArg smt2: γ ].
	(smtArgs zip: smtD) doAssociations: [ :eachArg :eachSort | self assert: eachArg sort == eachSort ].
	smtC := resultSort z3sort: γ.
	^ts tsInterp
		apply: s
		to: smtArgs
		ofZ3sorts: smtD
		returning: smtC
]

{ #category : #'SMT interface' }
InterpretedApp >> smt2Cast: s in: γ [
	self assert: self resultSort = s.
	^self smt2: γ
]

{ #category : #accessing }
InterpretedApp >> ts [
	^ ts
]

{ #category : #accessing }
InterpretedApp >> ts: anObject [
	ts := anObject
]
