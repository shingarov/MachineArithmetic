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
	^EApp fun: self toExpr imm: x toExpr
]

{ #category : #accessing }
DummyRVar >> value: x value: y [
	^EApp fun: (EApp fun: self toExpr imm: x toExpr) imm: y toExpr
]
