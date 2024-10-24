Extension { #name : #Z3Node }

{ #category : #'*PLE' }
Z3Node >> constEEqOrNil [
	^nil
]

{ #category : #'*PLE' }
Z3Node >> goFastEval: γ ctx: ictx in: anEvalEnvPLE [
	| f es es′ |
	self isPAnd   ifTrue: [ self shouldBeImplemented ].
	self isPOr    ifTrue: [ self shouldBeImplemented ].
	self isPNot   ifTrue: [ ^(self args first goFastEval: γ ctx: ictx in: anEvalEnvPLE) not ].
	self isPAtom  ifTrue: [ ^self goFastEvalAtom: γ ctx: ictx in: anEvalEnvPLE ].
	self isPIff   ifTrue: [ self shouldBeImplemented ].
	self isPImp   ifTrue: [ self shouldBeImplemented ].
	self isEBin ifTrue: [ ^self goFastEvalBin: γ ctx: ictx in: anEvalEnvPLE  ].
	self isEIte   ifTrue: [ | b eTrue eFalse |
				b := self args first.
				eTrue := self args second.
				eFalse := self args third.
				^γ fastEvalIte: ictx b: b e₁: eTrue e₂: eFalse in: anEvalEnvPLE ].
	self isECon ifTrue: [ ^self ].
	self isEVar ifTrue: [ ^self ].
	"what about pkvar?"
	self isPAll   ifTrue: [ self shouldBeImplemented ].
	self isExists ifTrue: [ self shouldBeImplemented ].

	self isApp ifFalse: [ self error "or did I miss anything??" ].
	"All that's left is EApp, it can't be anything else"
	f := self functorName .
	es := self args.
	es′ := es collect: [ :each | anEvalEnvPLE fastEval: γ ctx: ictx expr: each ].
	^γ evalApp: ictx f: f args: es′ in: anEvalEnvPLE
]

{ #category : #'*PLE' }
Z3Node >> goFastEvalAtom: γ ctx: ictx in: anEvalEnvPLE [
	| f args′ |
	(γ evalBool: self) ifNotNil: [ :b | ^b ].
	^self yourselfWithArguments:
		(self args collect: [ :eachArg | eachArg goFastEval: γ ctx: ictx in: anEvalEnvPLE ])
]

{ #category : #'*PLE' }
Z3Node >> goFastEvalBin: γ ctx: ictx in: anEvalEnvPLE [
	^self yourselfWithArguments:
		(self args collect: [ :eachArg | anEvalEnvPLE fastEval: γ ctx: ictx expr: eachArg ])
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
Z3Node >> normalizeBody: f [
	"BOGUS"
	^self
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
	^{self}, "BOGUS, WHAT HERE? WHAT ABOUT CURRY?? ++ go e1 ++ go e2" #()
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
	self isPIff   ifTrue: [ self shouldBeImplemented ].
	self isPImp   ifTrue: [ self shouldBeImplemented ].
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
