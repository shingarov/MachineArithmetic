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

{ #category : #polymorphism }
EImm >> elabS: Γ [
	| ts_n_t′ ts t′ n |
	ts_n_t′ := Γ immS: imm. ts := ts_n_t′ first.  n := ts_n_t′ second. t′ := ts_n_t′ last.
	^{ self mkTApp: ts n: n . t′ }
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

{ #category : #printing }
EImm >> spriteOn: aStream indent: level [
	"Print receiver on `aStream` as SpriteLang source"

	imm spriteOn: aStream indent: level
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

{ #category : #'α-renaming' }
EImm >> uniq2: α [
	^self class imm: (imm uniq2: α)

]
