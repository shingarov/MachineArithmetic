Class {
	#name : #L1Expression,
	#superclass : #SpriteExpression,
	#category : #SpriteLang
}

{ #category : #'instance creation' }
L1Expression class >> fromDecls: aSequenceableCollection [
	aSequenceableCollection isEmpty ifTrue: [ self error: 'aSequenceableCollection' ].
	^aSequenceableCollection size = 1
		ifTrue: [ L1ELet decl: aSequenceableCollection anyOne expr: (L1Expression int: 0) ]
		ifFalse: [ L1ELet decl: aSequenceableCollection first expr: (L1Expression fromDecls: aSequenceableCollection allButFirst) ]
]

{ #category : #'instance creation' }
L1Expression class >> int: anInteger [
	^L1EImm imm: (SpriteECon prim: (SpritePInt integer: anInteger))
]

{ #category : #verification }
L1Expression >> vcgen [
	self shouldBeImplemented
]
