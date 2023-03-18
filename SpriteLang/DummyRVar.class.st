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
	^EApp expr: self toExpr imm: x toExpr
]
