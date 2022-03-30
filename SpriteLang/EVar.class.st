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
	^self toFxEVar evaluateIn: aBindEnv
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
	| t |
	t := Γ getEnv: symbol. 
	^t
]

{ #category : #'as yet unclassified' }
EVar >> toFxEVar [
	^FxEVar of: symbol
]
