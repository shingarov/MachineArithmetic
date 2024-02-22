Class {
	#name : #ERApp,
	#superclass : #'ΛExpression',
	#instVars : [
		'expr'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
ERApp class >> expr: e [
	^self basicNew
		expr: e;
		yourself
]

{ #category : #accessing }
ERApp >> expr [
	^ expr
]

{ #category : #accessing }
ERApp >> expr: anObject [
	expr := anObject
]

{ #category : #polymorphism }
ERApp >> goSubsTyExpr: su [ 
	^ERApp expr: (expr goSubsTyExpr: su)
]

{ #category : #'α-renaming' }
ERApp >> rename: a to: b [
	^self class
		expr: (expr rename: a to: b)
]

{ #category : #'as yet unclassified' }
ERApp >> synth: Γ [
"
   Γ ⊦ e => ∀ r.s   r = K:t... -> bool    p = fresh(Γ, t...-> bool)
   ---------------------------------------------------------------- [Syn-RApp]
   Γ ⊦ e[?] => s [ r := p ]
"
	| c_s c s s′ |
	c_s := expr synth: Γ. c := c_s first. s := c_s last.
	s′ := s rinst.
	^{ c . s′ }
]
