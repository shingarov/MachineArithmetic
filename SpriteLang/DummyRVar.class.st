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

{ #category : #accessing }
DummyRVar >> value: x value: y [
	^EApp expr: (EApp expr: self toExpr imm: x toExpr) imm: y toExpr
]
