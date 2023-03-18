Class {
	#name : #DummyRVar,
	#superclass : #Cosa,
	#category : #SpriteLang
}

{ #category : #printing }
DummyRVar class >> description [
	^'rvar'
]

{ #category : #accessing }
DummyRVar >> value: x [
	^FxEApp expr: self toFxExpr imm: x toFxExpr
]
