Class {
	#name : #SpriteLangNegTest,
	#superclass : #SpriteLangTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #running }
SpriteLangNegTest >> processString: source [
	self proveUnsafe: source
]
