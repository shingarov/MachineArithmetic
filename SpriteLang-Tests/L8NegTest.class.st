Class {
	#name : #L8NegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests-Complete'
}

{ #category : #'tests-safety' }
L8NegTest >> test_XXXX [
	self processString: '
	
	
⟦ ⟧




'
]
