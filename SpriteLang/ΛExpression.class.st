Class {
	#name : #'ΛExpression',
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #'instance creation' }
ΛExpression class >> fromDecls: aSequenceableCollection [
	aSequenceableCollection isEmpty ifTrue: [ self error: 'Program has no decls' ].
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

{ #category : #polymorphism }
ΛExpression >> elaborate: Γ [
"
elaborate   :: Env -> SrcExpr -> ElbExpr
"
	| su e_ e__ su_e_ |
	su_e_ := ElabState runElabM: [ self elabC: Γ rtype: TInt instance bTrue ].
	su := su_e_ first.  e_ := su_e_ last.
	e__ := e_ subsTy: su.
	^e__
]

{ #category : #polymorphism }
ΛExpression >> goSubsTyExpr: su [
	self subclassResponsibility
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

{ #category : #polymorphism }
ΛExpression >> mkTApp: rtypes n: n [
n>0 ifTrue: [ self shouldBeImplemented ].
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

{ #category : #polymorphism }
ΛExpression >> subsTy: su [
	^self subsTyExpr: su
]

{ #category : #polymorphism }
ΛExpression >> subsTyExpr: su [
"
subsTyExpr :: TvSub -> ElbExpr -> ElbExpr
subsTyExpr su           = go
  where
    go (EFun b e l)     = EFun  b (go e)               l
    go (EApp e i l)     = EApp    (go e)  i            l
    go (ELet d e l)     = ELet    d'      (go e)       l where d' = subsTy su d
    go (EAnn e t l)     = EAnn    (go e)  t            l
    go (EIf  i e1 e2 l) = EIf   i (go e1) (go e2)      l
    go (ETLam a e l)    = ETLam a (go e)               l
    go (ETApp e t l)    = ETApp   (go e) (subsTy su t) l
    go (ECase x as l)   = ECase x (goA <$> as)         l
    go e@(EImm {})      = e
    goA alt             = alt -- { altTyArgs = fmap (subsTy su) <$> altTyArgs alt }
                              { altExpr = go $  altExpr   alt }
cf. Elaborate.hs
"
	^self goSubsTyExpr: su 
]
