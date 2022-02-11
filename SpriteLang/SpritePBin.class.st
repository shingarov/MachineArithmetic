Class {
	#name : #SpritePBin,
	#superclass : #SpritePrim,
	#instVars : [
		'primOp'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
SpritePBin class >> primOp: primOp [
	^self basicNew primOp: primOp; yourself 
]

{ #category : #accessing }
SpritePBin >> primOp [
	^ primOp
]

{ #category : #accessing }
SpritePBin >> primOp: anObject [
	primOp := anObject
]
