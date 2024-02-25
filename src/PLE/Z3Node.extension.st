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
	self isPNot   ifTrue: [ self shouldBeImplemented ].
	self isPAtom  ifTrue: [ self shouldBeImplemented ].
	self isPIff   ifTrue: [ self shouldBeImplemented ].
	self isPImp   ifTrue: [ self shouldBeImplemented ].
	self isEBin ifTrue: [ ^self ].
	self isEIte   ifTrue: [ | b eTrue eFalse |
				b := self args first.
				eTrue := self args second.
				eFalse := self args third.
				^γ fastEvalIte: ictx b: b e₁: eTrue e₂: eFalse ].
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
	^γ evalApp: ctx f: f args: es′ in: anEvalEnvPLE
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
"
	self isPAnd   ifTrue: [ self shouldBeImplemented ].
	self isPOr    ifTrue: [ self shouldBeImplemented ].
	self isPNot   ifTrue: [ ^self args first notGuardedApps ].
	self isPAtom  ifTrue: [ ^self args first notGuardedApps, self args second notGuardedApps ].
	self isPIff   ifTrue: [ self shouldBeImplemented ].
	self isPImp   ifTrue: [ self shouldBeImplemented ].
	self isEBin   ifTrue: [ self args first notGuardedApps, self args second notGuardedApps ].
	self isEIte   ifTrue: [ self shouldBeImplemented ].
	self isECon   ifTrue: [ ^#() ].
	self isEVar   ifTrue: [ ^#() ].
	"what about pkvar?"
	self isPAll   ifTrue: [ self shouldBeImplemented ].
	self isExists ifTrue: [ self shouldBeImplemented ].

	self isApp ifFalse: [ self error "or did I miss anything??" ].
	"All that's left is EApp, it can't be anything else"
	^{self}, "BOGUS, WHAT HERE? WHAT ABOUT CURRY?? ++ go e1 ++ go e2" #()
]
