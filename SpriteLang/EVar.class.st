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

{ #category : #'as yet unclassified' }
EVar >> evaluateIn: aBindEnv [ 
	^self toFX evaluateIn: aBindEnv
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
