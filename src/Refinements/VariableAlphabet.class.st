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
	^self freshVariableName:'VV'
]

{ #category : #API }
VariableAlphabet class >> freshVariableName: prefix [
	j isNil ifTrue: [ j:= 0 ].
	j := j + 1.
	^prefix, j printString
]
