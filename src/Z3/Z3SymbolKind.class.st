Class {
	#name : #Z3SymbolKind,
	#superclass : #SharedPool,
	#classVars : [
		'INT_SYMBOL',
		'STRING_SYMBOL'
	],
	#category : #'Z3-Core'
}

{ #category : #initialization }
Z3SymbolKind class >> initialize [
	INT_SYMBOL := 0.
	STRING_SYMBOL := 1.

]
