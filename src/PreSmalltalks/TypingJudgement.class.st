Class {
	#name : #TypingJudgement,
	#superclass : #Object,
	#instVars : [
		'term',
		'type'
	],
	#category : #PreSmalltalks
}

{ #category : #'instance creation' }
TypingJudgement class >> term: term hasType: type [
	^self new term: term type: type
]

{ #category : #accessing }
TypingJudgement >> term [
	^ term
]

{ #category : #initialization }
TypingJudgement >> term: termArg type: typeArg [
	term := termArg.
	type := typeArg.

]

{ #category : #accessing }
TypingJudgement >> type [
	^ type
]
