Class {
	#name : #L8NegTest,
	#superclass : #SpriteLangNegTest,
	#category : #'SpriteLang-Tests'
}

{ #category : #'tests-safety' }
L8NegTest >> test_XXXX [
	self processString: '
	
	
⟦ ⟧




'
]
