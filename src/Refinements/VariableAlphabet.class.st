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
	j isNil ifTrue: [ j:= 0 ].
	j := j + 1.
	^'VV', j printString 
]
