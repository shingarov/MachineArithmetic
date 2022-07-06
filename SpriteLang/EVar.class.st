Class {
	#name : #EVar,
	#superclass : #SpriteImm,
	#instVars : [
		'symbol'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
EVar class >> symbol: s [
	^self basicNew symbol: s; yourself 
]

{ #category : #comparing }
EVar >> = anotherEVar [
	anotherEVar class = self class ifFalse: [ ^false ].
	^symbol = anotherEVar symbol
]

{ #category : #'as yet unclassified' }
EVar >> evaluateIn: aBindEnv [ 
	^self toFX evaluateIn: aBindEnv
]

{ #category : #comparing }
EVar >> hash [
	^symbol hash
]

{ #category : #'as yet unclassified' }
EVar >> immTy: Γ [
	^Γ at: symbol
]

{ #category : #accessing }
EVar >> sym [
	^ symbol
]

{ #category : #accessing }
EVar >> symbol [
	^ symbol
]

{ #category : #accessing }
EVar >> symbol: anObject [
	symbol := anObject
]

{ #category : #verification }
EVar >> synthImm: Γ [
"
    
     ---------------- [Syn-Var]
      Γ ⊦ x ==> Γ(x)
"
	| t |
	t := Γ getEnv: symbol. 
	^t singleton: symbol
]

{ #category : #'as yet unclassified' }
EVar >> toFX [
	^FxEVar of: symbol
]
