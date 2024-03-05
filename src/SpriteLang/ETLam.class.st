"
Type abstraction:  Λa. e
"
Class {
	#name : #ETLam,
	#superclass : #'ΛExpression',
	#instVars : [
		'tvar',
		'expr'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
ETLam class >> tvar: v expr: e [
	^self basicNew
		tvar: v;
		expr: e;
		yourself
]

{ #category : #verification }
ETLam >> check: Γ rtype: f [
" 
      Γ, a ⊦ e <== t
      ------------------------- [Chk-TLam]
      Γ ⊦ Λa. e <== all a. t
"
	((f isKindOf: TAll) and: [ tvar = f var ]) ifTrue: [ ^expr check: Γ rtype: f type ].
	^super check: Γ rtype: f
]

{ #category : #accessing }
ETLam >> expr [
	^ expr
]

{ #category : #accessing }
ETLam >> expr: anObject [
	expr := anObject
]

{ #category : #'as yet unclassified' }
ETLam >> goSubsTyExpr: su [ 
	^ETLam tvar: tvar expr: (expr goSubsTyExpr: su)
]

{ #category : #GT }
ETLam >> gtChildren [
	^{expr}
]

{ #category : #'as yet unclassified' }
ETLam >> renameTy: ty metric: m [
	| t′_m′ t′ m′ |
	(ty isKindOf: TAll) ifFalse: [ ^super renameTy: ty metric: m ].
	t′_m′ := expr renameTy: ty type metric: m.
	t′ := t′_m′ key. m′ := t′_m′ value.
	^(TAll
		var: ty var
		type: t′)  -> m′
]

{ #category : #accessing }
ETLam >> tvar [
	^ tvar
]

{ #category : #accessing }
ETLam >> tvar: anObject [
	tvar := anObject
]
