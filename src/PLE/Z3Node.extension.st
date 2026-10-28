Extension { #name : #Z3Node }

{ #category : #'*PLE' }
Z3Node >> constEEqOrNil [
	^nil
]

{ #category : #'*PLE' }
Z3Node >> evalApp: γ ictx: ictx args: es et: et [
"
Unfold expressions in @eApps e es@ using rewrites and equations.
evalApp :: Knowledge -> ICtx -> Expr -> [Expr] -> EvalType -> EvalST (Maybe Expr, FinalExpand)
cf. PLE.hs
"
	| evEnv f eq nts newE |
	self funcDecl isTheoryKind ifTrue: [ ^self->false ].
	f := self functorName.
	evEnv := (Context readState: #EvEnv) evEnv.
	nts := evEnv naturalTransformations.
	eq :=  γ knAms detect: [ :each | each hasComponent: f among: nts ]
		ifNone: [ self shouldBeImplemented ].
	newE := eq substEq: evEnv sort es: es.
	newE := newE elaborate: evEnv.
	newE := newE smt2: evEnv.
	^γ shortcut: newE ctx: ictx et: et expand: false
]

{ #category : #'*PLE' }
Z3Node >> goEval: γ ctx: ictx et: et [
	| f es es′ es′_fe fe e′_fe′ e′ fe′ |
	self isPAnd   ifTrue: [ self shouldBeImplemented ].
	self isPOr    ifTrue: [ self shouldBeImplemented ].
	self isPNot   ifTrue: [ ^(self args first goEval: γ ctx: ictx et: et) not ].
	self isPAtom  ifTrue: [ ^self goEvalAtom: γ ctx: ictx et:et ].
	self isPIff   ifTrue: [ self shouldBeImplemented ].
	self isPImp   ifTrue: [ self shouldBeImplemented ].
	self isEBin ifTrue: [ ^self goEvalBin: γ ctx: ictx et: et  ].
	self isEIte   ifTrue: [ | b eTrue eFalse |
				b := self args first.
				eTrue := self args second.
				eFalse := self args third.
				^γ evalIte: ictx b: b e₁: eTrue e₂: eFalse et: et ].
	self isECon ifTrue: [ ^self -> false ].
	self isEVar ifTrue: [ ^self -> false ].
	"what about pkvar?"
	self isPAll   ifTrue: [ self shouldBeImplemented ].
	self isExists ifTrue: [ self shouldBeImplemented ].

	self isApp ifFalse: [ self error "or did I miss anything??" ].
	"All that's left is EApp, it can't be anything else"
	"go e@(EApp _ _)     = ..."
	(et isKindOf: NoRW) ifFalse: [ self shouldBeImplemented ].
	es := self args.
	es′_fe := (es collect: [ :each | γ eval: each ctx: ictx et: et ]) feSeq.
	es′ := es′_fe key.  fe := es′_fe value.
	e′_fe′ := self evalApp: γ ictx: ictx args: es′ et: et.
	e′ := e′_fe′ key.  fe′ := e′_fe′ value.
	^e′ -> (Knowledge feChoose: fe rhs: fe′)
]

{ #category : #'*PLE' }
Z3Node >> goEvalAtom: γ ctx: ictx et: et [
	| b |
	b := γ evalBool: self.
	b isNil
		ifFalse: [ ^b -> false ]
		ifTrue: [
			| e1′_fe1 e2′_fe2 e1′ fe1 e2′ fe2 |
			self assert: self args size = 2.
			e1′_fe1 := γ eval: self args first ctx:ictx  et: et.
			e1′ := e1′_fe1 key.  fe1 := e1′_fe1 value.
			e2′_fe2 := γ eval: self args second ctx:ictx  et: et.
			e2′ := e2′_fe2 key.  fe2 := e2′_fe2 value.
			^(self yourselfWithArguments: { e1′ . e2′ }) -> (Knowledge feChoose: fe1 rhs: fe2)	
		]
]

{ #category : #'*PLE' }
Z3Node >> goEvalBin: γ ctx: ictx et: et [
	| e1′_fe1 e2′_fe2 e1′ fe1 e2′ fe2 |
	self assert: self args size = 2.
	e1′_fe1 := γ eval: self args first ctx:ictx  et: et.
	e1′ := e1′_fe1 key.  fe1 := e1′_fe1 value.
	e2′_fe2 := γ eval: self args second ctx:ictx  et: et.
	e2′ := e2′_fe2 key.  fe2 := e2′_fe2 value.
	^(self yourselfWithArguments: { e1′ . e2′ }) -> (Knowledge feChoose: fe1 rhs: fe2)
]

{ #category : #'*PLE' }
Z3Node >> isDataConstant: dcs [
"
isConstant :: S.HashSet LDataCon -> Expr -> Bool
                          dcs        e
cf. PLE.hs
"
	^(self justVariables difference: dcs) isEmpty
]

{ #category : #'*PLE' }
Z3Node >> isGoodApp: aKnowledge [
"
isGoodApp :: Knowledge -> Expr -> Bool
Cf PLE.hs
"
	| f es i |
	"| (EVar f, es) <- splitEApp e"
	self isApp ifFalse: [ ^false ].
	
	f := NaturalTransformation componentNameToNTName: self functorName.
	es := self args.

	", Just i       <- L.lookup f (knSummary γ)"
	i := (Dictionary newFromAssociations: aKnowledge knSummary)
		at: f
		ifAbsent: [ ^false ].
	^es size >= i
]

{ #category : #'*PLE' }
Z3Node >> isRedex: aKnowledge [
"
isRedex :: Knowledge -> Expr -> Bool
Cf. PLE.hs
"
	^self isEIte or: [ self isGoodApp: aKnowledge ]
]

{ #category : #'*PLE' }
Z3Node >> normalizeBody: f [
"
normalizeBody :: Symbol -> Expr -> Expr
" 
	^f ∈ self syms
		ifTrue: [ self normalizeBody′: f ]
		ifFalse: [ self ]
]

{ #category : #'*PLE' }
Z3Node >> notGuardedApps [
"
  -- | @notGuardedApps e@ yields all the subexpressions that are
  -- applications not under an if-then-else, lambda abstraction, type abstraction,
  -- type application, or quantifier.
notGuardedApps :: Expr -> [Expr]
"
	self isPAnd   ifTrue: [ ^self args >>= #notGuardedApps ].
	self isPOr    ifTrue: [ ^self args >>= #notGuardedApps ].
	self isPNot   ifTrue: [ ^self args first notGuardedApps ].
	self isPAtom  ifTrue: [ ^self args first notGuardedApps, self args second notGuardedApps ].
	self isPIff   ifTrue: [ ^self args first notGuardedApps, self args second notGuardedApps ].
	self isPImp   ifTrue: [ ^self args first notGuardedApps, self args second notGuardedApps ].
	self isEBin   ifTrue: [ ^self args first notGuardedApps, self args second notGuardedApps ].
	self isEIte   ifTrue: [ ^self args first notGuardedApps, {self} ].
	self isECon   ifTrue: [ ^#() ].
	self isEVar   ifTrue: [ ^#() ].
	"what about pkvar?"
	self isPAll   ifTrue: [ self shouldBeImplemented ].
	self isExists ifTrue: [ self shouldBeImplemented ].

	self isApp ifFalse: [ self error "or did I miss anything??" ].
	"All that's left is EApp, it can't be anything else"
	^{self}, (self args >>= #notGuardedApps)
]

{ #category : #'*PLE' }
Z3Node >> simplify: γ in: ictx [
	^[ :x | (x simplifyStep: γ in: ictx) "simplify" ] fix: self
]

{ #category : #'*PLE' }
Z3Node >> simplifyStep: γ in: ictx [
	ictx icSimpl at: self ifPresent: [ :self′ | ^self′ ].

	self isPAnd   ifTrue: [ self shouldBeImplemented ].
	self isPOr    ifTrue: [ self shouldBeImplemented ].
	self isPNot   ifTrue: [ self shouldBeImplemented ].
	self isPAtom  ifTrue: [ ^self yourselfWithArguments: (self args collect: [ :ea | ea simplify: γ in: ictx ]) ].
	self isPIff   ifTrue: [ ^((self args first simplifyStep: γ in: ictx) <=> (self args second simplifyStep: γ in: ictx)) simplify ].
	self isPImp   ifTrue: [ ^((self args first simplifyStep: γ in: ictx) ==> (self args second simplifyStep: γ in: ictx)) simplify ].
	self isEBin   ifTrue: [ ^self yourselfWithArguments: (self args collect: [ :ea | ea simplify: γ in: ictx ]) ].
	self isEIte   ifTrue: [
			| b |
			b := self args first simplify.
			b = Bool true  ifTrue: [ ^self args second simplify: γ in: ictx ].
			b = Bool false ifTrue: [ ^self args third  simplify: γ in: ictx ].
			^b
				ifThen: ( self args second simplify: γ in: ictx )
				else:   ( self args third  simplify: γ in: ictx )
	].
	self isECon   ifTrue: [ ^self ].
	self isEVar   ifTrue: [ ^self ].
	"what about pkvar?"
	self isPAll   ifTrue: [ self shouldBeImplemented ].
	self isExists ifTrue: [ self shouldBeImplemented ].

	self isApp ifFalse: [ self error "or did I miss anything??" ].
	"All that's left is EApp, it can't be anything else"
	
	^self "BOGUS, knSels business"
]

{ #category : #'*PLE' }
Z3Node >> skipElabExpr: _ [
	^self
]
