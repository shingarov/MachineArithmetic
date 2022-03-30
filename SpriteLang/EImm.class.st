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
