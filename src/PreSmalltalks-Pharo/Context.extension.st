Extension { #name : #Context }

{ #category : #'*PreSmalltalks-Pharo' }
Context >> lookupSymbol: aSymbol ifAbsent: aBlockClosure [ 
	| var |
	var := (self sourceNodeExecuted scope) lookupVar: aSymbol.
	var isNil ifTrue: [ ^aBlockClosure value ].
	"Local variables"
	var isTemp ifTrue: [^ self tempNamed: aSymbol].
	"Instance variables"
	var isInstance ifTrue: [^ self receiver instVarNamed: aSymbol].
	"Class variables and globals"
	var isGlobal ifTrue: [ ^ var assoc value ].
	^aBlockClosure value
]
