Class {
	#name : #L1EImm,
	#superclass : #L1Expression,
	#instVars : [
		'imm'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
L1EImm class >> imm: imm [
	^self basicNew imm: imm; yourself
]

{ #category : #accessing }
L1EImm >> imm [
	^ imm
]

{ #category : #accessing }
L1EImm >> imm: anObject [
	imm := anObject
]

{ #category : #'as yet unclassified' }
L1EImm >> immYourself [
	^self
]
