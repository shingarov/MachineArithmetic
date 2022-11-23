Class {
	#name : #FxEApp,
	#superclass : #Object,
	#instVars : [
		'expr',
		'imm'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FxEApp class >> expr: e imm: i [ 
	^ self basicNew 
		expr: e;
		imm: i;
		yourself
]

{ #category : #'as yet unclassified' }
FxEApp >> elab: anElabEnv [
	| elabResults f x |
	(expr isKindOf: FxEApp) ifTrue: [self shouldBeImplemented "EAPP-EAPP" ].

	elabResults := anElabEnv elabEApp: expr _: imm.
	f := elabResults second z3sort.
	x := elabResults fourth z3sort.
	
	anElabEnv senv sort note: imm  elaboratedTo: x.
	anElabEnv senv sort note: expr elaboratedTo: f.
	
	^{f.x}
]

{ #category : #accessing }
FxEApp >> expr [
	^ expr
]

{ #category : #accessing }
FxEApp >> expr: anObject [
	expr := anObject
]

{ #category : #accessing }
FxEApp >> imm [
	^ imm
]

{ #category : #accessing }
FxEApp >> imm: anObject [
	imm := anObject
]
