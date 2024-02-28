"
Type application: e [t]
"
Class {
	#name : #ETApp,
	#superclass : #'ΛExpression',
	#instVars : [
		'expr',
		'rtype'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
ETApp class >> expr: e rtype: t [
	^self basicNew expr: e; rtype: t; yourself
]

{ #category : #reflect }
ETApp >> bkAppT: tArgs [
	^expr bkAppT: {rtype},tArgs
]

{ #category : #accessing }
ETApp >> expr [
	^ expr
]

{ #category : #accessing }
ETApp >> expr: anObject [
	expr := anObject
]

{ #category : #'as yet unclassified' }
ETApp >> goSubsTyExpr: su [ 
	^ETApp expr: (expr goSubsTyExpr: su) rtype: (rtype subsTy: su)
]

{ #category : #accessing }
ETApp >> rtype [
	^ rtype
]

{ #category : #accessing }
ETApp >> rtype: anObject [
	rtype := anObject
]

{ #category : #'as yet unclassified' }
ETApp >> synth: Γ [
"
     Γ ⊦ e ==> all a. s
     ----------------------- [Syn-TApp]
     Γ ⊦ e[t] ==> s [a := t]
"
	| ce_te ce te tt |
	ce_te := expr synth: Γ.
	ce := ce_te first.  te := ce_te last.
	(te isKindOf: TAll) ifFalse: [ self error: 'Type Application to non-forall' ].
	tt := Γ refresh: rtype.
	^{ ce . te type tsubst: tt tVar: te var }
]
