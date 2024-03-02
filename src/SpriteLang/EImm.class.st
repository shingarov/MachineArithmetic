Class {
	#name : #EImm,
	#superclass : #'ΛExpression',
	#instVars : [
		'imm'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
EImm class >> imm: imm [
	^self basicNew imm: imm; yourself
]

{ #category : #'as yet unclassified' }
EImm >> elabS: Γ [
	| ts_n_t1 ts t1 n |
	ts_n_t1 := Γ immS: imm. ts := ts_n_t1 first.  n := ts_n_t1 second. t1 := ts_n_t1 last.
	^{ self mkTApp: ts n: n . t1 }
]

{ #category : #'reflect - embedding' }
EImm >> embed [
	^imm embedImm
]

{ #category : #'as yet unclassified' }
EImm >> goSubsTyExpr: su [ 
	^self
]

{ #category : #accessing }
EImm >> imm [
	^ imm
]

{ #category : #accessing }
EImm >> imm: anObject [
	imm := anObject
]

{ #category : #'as yet unclassified' }
EImm >> immYourself [
	^self
]

{ #category : #inlining }
EImm >> inlineFunction: f λ: x body: b [
	^EImm imm: (imm inlineFunction: f λ: x body: b)
]

{ #category : #inlining }
EImm >> macroExpandEVar: x to: aΛExpr [
	^EImm imm: (imm macroExpandEVar: x to: aΛExpr)
]

{ #category : #'as yet unclassified' }
EImm >> synth: Γ [
"
{- [Syn-Con], [Syn-Var] -}
  synth g (EImm i _) = do
    t <- synthImm g i
    return (cTrue, t)
"
	| t |
	t := imm synthImm: Γ.
	^{ HCstr cTrue . t }
]
