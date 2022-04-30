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

{ #category : #polymorphism }
ΛExpression >> elabC: Γ rtype: t [
	| e1_t1 e_ t_ |
	e1_t1 := self elabS: Γ.
	e_ := e1_t1 first.  t_ := e1_t1 last.
	t unify: t_.
	^e_
]

{ #category : #'as yet unclassified' }
ΛExpression >> elaborate [
	| su e_ e__ su_e_ |
	su_e_ := ElabState runElabM: [ self elabC: ΓContext empEnv rtype: TInt instance bTrue ].
	su := su_e_ first.  e_ := su_e_ last.
	e__ := e_ subsTy: su.
	^e__
]

{ #category : #GT }
ΛExpression >> gtChildren [
	^#()
]

{ #category : #GT }
ΛExpression >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 50>
	^ composite fastTree
		title: 'Tree';
		children: #gtChildren;
		display: [ Array with: self ]
]

{ #category : #'as yet unclassified' }
ΛExpression >> mkTApp: rtypes [ 
	^rtypes inject: self into: [ :e :t | ETApp expr: e rtype: t ]
]

{ #category : #polymorphism }
ΛExpression >> mkTLam: tVars [
	^tVars reversed inject: self into: [ :exprSoFar :thisVar | ETLam tvar: thisVar expr: exprSoFar ]
]

{ #category : #printing }
ΛExpression >> printOn: aStream [
	self printStructOn: aStream
]

{ #category : #'as yet unclassified' }
ΛExpression >> solveWithQualifiers: qs [
	^(self vcgenWithQualifiers: qs) solve
]

{ #category : #'as yet unclassified' }
ΛExpression >> subsTy: su [ 
	^self subsTyExpr: su
]

{ #category : #'as yet unclassified' }
ΛExpression >> subsTyExpr: su [ 
	^self goSubsTyExpr: su 
]

{ #category : #'as yet unclassified' }
ΛExpression >> vcgen [
	| cstr query |
	cstr := self check: ΓContext empEnv rtype: TInt instance bTrue.
	query := HornQuery new.
	cstr addToQuery: query.
	^query
]

{ #category : #'as yet unclassified' }
ΛExpression >> vcgenWithQualifiers: qs [
	| query cstr |
	CGState reset.
	cstr := self elaborate check: ΓContext empEnv rtype: TInt instance bTrue.
	query := HornQuery new.
	cstr addToQuery: query.
	CGState current kVars do: [ :kVar | kVar addToQuery: query ].
	qs do: [ :q | q addToQuery: query ].
	^query
]
