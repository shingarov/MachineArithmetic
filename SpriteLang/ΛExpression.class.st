Class {
	#name : #'ΛExpression',
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #'instance creation' }
ΛExpression class >> fromDecls: aSequenceableCollection [
	aSequenceableCollection isEmpty ifTrue: [ self error: 'aSequenceableCollection' ].
	^aSequenceableCollection size = 1
		ifTrue: [ ELet decl: aSequenceableCollection anyOne expr: (ΛExpression int: 0) ]
		ifFalse: [ ELet decl: aSequenceableCollection first expr: (ΛExpression fromDecls: aSequenceableCollection allButFirst) ]
]

{ #category : #'instance creation' }
ΛExpression class >> int: anInteger [
	^EImm imm: (ECon prim: (PInt integer: anInteger))
]

{ #category : #verification }
ΛExpression >> check: Γ rtype: t [
"
      Γ ⊦ e ==> s        Γ ⊦ s ≺ t
      --------------------------------[Chk-Syn]
                Γ ⊦ e <== t
"
	| c_s c s c1 |
	c_s := self synth: Γ.
	c := c_s first.
	s := c_s last.
	c1 := s ≺ t.
	^c & c1
]

{ #category : #printing }
ΛExpression >> printOn: aStream [
	self printStructOn: aStream
]

{ #category : #'as yet unclassified' }
ΛExpression >> solve [
	^self vcgen solve
]

{ #category : #'as yet unclassified' }
ΛExpression >> vcgen [
	| cstr query |
	cstr := self check: ΓContext empEnv rtype: TInt instance bTrue.
	query := HornQuery new.
	cstr addToQuery: query.
	^query
]
