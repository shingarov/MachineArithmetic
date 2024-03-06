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

{ #category : #reflect }
ΛExpression >> bkApp [
	^self bkApp: #()
]

{ #category : #reflect }
ΛExpression >> bkApp: vArgs [ 
	^(self bkAppT: #()) -> vArgs
]

{ #category : #reflect }
ΛExpression >> bkAppT: tArgs [
	^self -> tArgs
]

{ #category : #verification }
ΛExpression >> check: Γ rtype: t [
"
check :: Env -> SrcExpr -> RType -> CG SrcCstr
          Γ      self       t
"
"
      Γ ⊦ e ==> s        Γ ⊦ s ≺ t
      --------------------------------[Chk-Syn]
                Γ ⊦ e <== t
"
	| c_s c s c′ |
	(t isKindOf: TRAll) ifTrue: [ ^self checkRAbs: Γ rtype: t ].
	c_s := self synth: Γ.
	c := c_s first.
	s := c_s last.
	c′ := s ≺ t.
	^c & c′
]

{ #category : #'as yet unclassified' }
ΛExpression >> checkRAbs: Γ rtype: aTRAll [
"
    ρ = κ:t -> Bool   s' = s[κ := fκ]   G; fκ : t → Bool ⊢ e <== s' 
    ----------------------------------------------------------------[Chk-RAbs]
              G |- e <== all ρ. s
"
	| r s kf_kt kf kt Γ1 s1 c |
	r := aTRAll r.
	s := aTRAll t.
	kf_kt := r predBind. kf := kf_kt key. kt := kf_kt value.
	Γ1 := Γ extEnv: kf rtype: kt.
	s1 := s collect: [ :inside | inside hvarPred: kf ].
	c := self check: Γ1 rtype: s1.
	^kt cAllF: kf cstr: c
]

{ #category : #polymorphism }
ΛExpression >> elabC: Γ rtype: t [
	| e1_t1 e_ t_ |
	e1_t1 := self elabS: Γ.
	e_ := e1_t1 first.  t_ := e1_t1 last.
	t unify: t_.
	^e_
]

{ #category : #verification }
ΛExpression >> elabS: aΓContext [ 
	self error: 'elabS can only be sent to EImm, EAnn, or ΛEapp'
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

{ #category : #'reflect - embedding' }
ΛExpression >> embed [
	^self subclassResponsibility
]

{ #category : #polymorphism }
ΛExpression >> goSubsTyExpr: su [
	self subclassResponsibility
]

{ #category : #GT }
ΛExpression >> gtBind [
	^''
]

{ #category : #GT }
ΛExpression >> gtChildren [
	^#()
]

{ #category : #GT }
ΛExpression >> gtExpr [
	^self
]

{ #category : #GT }
ΛExpression >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 50>

	| flatten |

	flatten := [ :children |
		OrderedCollection streamContents:[:flattened|
			children do:[:child |
				| c |
				c := child.
				[ c notNil ] whileTrue:[
					flattened nextPut: c.
					c := c isLet ifTrue:[c expr] ifFalse:[nil].
				].
			]
		]
	].

	^ composite fastTreeTable
		title: 'Tree';
		children: [:expr | flatten value: expr gtChildren  ];
		display: [ flatten value: { self } ];
		column: 'Class'evaluated: [ :e | e class name ];
		column: 'Bind' evaluated: [ :e | e gtBind ];
		column: 'Expr' evaluated: [ :e | e gtExpr ];
		yourself.
]

{ #category : #testing }
ΛExpression >> isFun [
	^false
]

{ #category : #testing }
ΛExpression >> isLet [
	^false
]

{ #category : #inlining }
ΛExpression >> macroExpandEVar: f to: aΛExpr [
	"Traverse self, replacing all occurrences of «f» with aΛExpr;
	 with the only special case when self is (ΛEApp (EImm «f») a)
	 and aΛExpr is a sprite function (EFun λx body), in which case
	 replace the ΛEapp with body[x:=a]."
	self subclassResponsibility
]

{ #category : #polymorphism }
ΛExpression >> mkRApps: k [
	k = 0 ifTrue: [ ^self ].
	^(ERApp expr: self) mkRApps: k-1
]

{ #category : #polymorphism }
ΛExpression >> mkTApp: rtypes n: n [
	^(self mkTApps: rtypes) mkRApps: n
]

{ #category : #polymorphism }
ΛExpression >> mkTApps: rtypes [
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
ΛExpression >> renameTy: t metric: m [
"
Replace the types in a signature with those in the function definition.
renameTy :: SrcExpr -> RType -> Metric -> (RType, Metric)
"
	^t->m

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

{ #category : #'α-renaming' }
ΛExpression >> uniq2: α [
	"α-rename all variables. Returns a copy of receiver with all names unique."

	self subclassResponsibility.
]

{ #category : #'well-formedness' }
ΛExpression >> wfExpr: γ sort: t [
"
wfExpr :: F.SrcSpan -> Env -> F.Expr -> F.Sort -> Bool
"
	^(self checkSortExpr: γ eSorts) = t
]
