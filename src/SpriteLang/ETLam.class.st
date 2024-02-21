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
self shouldBeImplemented
]

{ #category : #accessing }
ETLam >> tvar [
	^ tvar
]

{ #category : #accessing }
ETLam >> tvar: anObject [
	tvar := anObject
]

{ #category : #'α-renaming' }
ETLam >> uniq2: α [
	self shouldBeImplemented
]
