Class {
	#name : #VariableAlphabet,
	#superclass : #Object,
	#classVars : [
		'j'
	],
	#category : #Refinements
}

{ #category : #API }
VariableAlphabet class >> freshVariableName [
	^'VV', self nextJ printString
]

{ #category : #API }
VariableAlphabet class >> nextJ [
	j isNil ifTrue: [ j:= 0 ].
	j := j + 1.
	^j
]
