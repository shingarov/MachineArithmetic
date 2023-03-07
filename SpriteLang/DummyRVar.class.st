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
	^RefVarApp var: varName args: {x varName}
]
