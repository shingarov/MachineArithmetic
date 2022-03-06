Class {
	#name : #TartagliaContext,
	#superclass : #Object,
	#instVars : [
		'cosas',
		'tempNames'
	],
	#category : #CardanoTartaglia
}

{ #category : #API }
TartagliaContext class >> evaluate: sourceString [
	| compiler |
	compiler := self compilerClass new.
	compiler
		noPattern: true;
		source: sourceString.
	compiler context: (self withLiterals: compiler compile literals).
	^compiler evaluate
]

{ #category : #'instance creation' }
TartagliaContext class >> withLiterals: coll [ 
	| undeclared |
	undeclared := coll
		select: [ :l | l class = UndeclaredVariable ]
		thenCollect: #key.
	^self new tempNames: undeclared
		
]

{ #category : #accessing }
TartagliaContext >> cosas [
	cosas isNil ifTrue: [ cosas := Dictionary new ].
	^cosas
]

{ #category : #accessing }
TartagliaContext >> method [
	^SmallInteger >> #*
]

{ #category : #accessing }
TartagliaContext >> receiver [
	^nil
]

{ #category : #accessing }
TartagliaContext >> tempNamed: aString [
	^self cosas
		at: aString ifAbsentPut: [ Cosa named: aString ]
]

{ #category : #accessing }
TartagliaContext >> tempNames [
	^tempNames 
]

{ #category : #accessing }
TartagliaContext >> tempNames: anArrayOfSymbols [
	tempNames := anArrayOfSymbols 
]
