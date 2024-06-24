Class {
	#name : #SectionArgumentNode,
	#superclass : #RBVariableNode,
	#classVars : [
		'N'
	],
	#category : #'MathNotation-Pharo'
}

{ #category : #naming }
SectionArgumentNode class >> freshName [
	^'_ß', self nextN printString
]

{ #category : #'instance creation' }
SectionArgumentNode class >> newAt: aPosition [
	^self
		identifierNamed: self freshName
		at: aPosition
]

{ #category : #naming }
SectionArgumentNode class >> nextN [
	N isNil ifTrue: [ N :=0 ].
	N := N+1.
	^N
]

{ #category : #substitution }
SectionArgumentNode >> holePlug [
	^RBVariableNode named: name start: start
]

{ #category : #testing }
SectionArgumentNode >> isSectionArgument [
	^true
]

{ #category : #accessing }
SectionArgumentNode >> parent: p [
	(p isKindOf: RBMessageNode) ifFalse: [
		self parserError: '□ can only be a message''s arg or receiver'
	].
	^super parent: p
]
