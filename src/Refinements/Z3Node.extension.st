Extension { #name : #Z3Node }

{ #category : #'*Refinements' }
Z3Node >> accept: aVisitor [ 
	^self "TODO: is this right? we introduced this for monomorphisation"
]

{ #category : #'*Refinements' }
Z3Node >> applyExpr: θ [ 
	^self
]

{ #category : #'*Refinements' }
Z3Node >> checkExpr: _ [ 
	^self sort
]

{ #category : #'*Refinements' }
Z3Node >> eCstAtom: _ inElabEnv: _′ [
	^ECst
		e: self
		sort: self sort
]

{ #category : #'*Refinements' }
Z3Node >> elab: anElabEnv [ 
	^{ self . self sort }
]

{ #category : #'*Refinements' }
Z3Node >> elabAs: t inElabEnv: _ [ 
	t = self sort ifFalse: [ self error ].
	^self
	
]

{ #category : #'*Refinements' }
Z3Node >> expr [
	^self
]

{ #category : #'*Refinements' }
Z3Node >> isEBin [
	"Answer whether Fixpoint would consider this node a EBin."
	self isApp ifFalse: [ ^false ].
	self arity = 2 ifFalse: [ ^false ].
	^#('+' '-' '*' 'div' 'mod') includes: self functorName
]

{ #category : #'*Refinements' }
Z3Node >> isECon [
	"Answer whether Fixpoint would consider this node a ECon."
	^self kind = NUMERAL_AST
]

{ #category : #'*Refinements' }
Z3Node >> isEIte [
	"Answer whether Fixpoint would consider this node a EIte."
	self isApp ifFalse: [ ^false ].
	self functorName = 'if' ifFalse: [ ^false ].
	self arity = 3 ifFalse: [ ^false ].
	^self args first isBool
]

{ #category : #'*Refinements' }
Z3Node >> isEUnclassified [
	| declKind |

	declKind := self funcDeclKind.
	^declKind == Z3_OP_RECURSIVE or:[declKind == Z3_OP_UNINTERPRETED ]
]

{ #category : #'*Refinements' }
Z3Node >> isEVar [
	"Answer whether Fixpoint would consider this node a EVar."
	^self isConstant
]

{ #category : #'*Refinements' }
Z3Node >> isPAll [
	"Answer whether Fixpoint would consider this node a PAll."
	^false
]

{ #category : #'*Refinements' }
Z3Node >> isPAnd [
	"Answer whether Fixpoint would consider this node a PAnd."
	^false
]

{ #category : #'*Refinements' }
Z3Node >> isPAtom [
	"Answer whether Fixpoint would consider this node a PAtom.
	 A PAtom is (Brel e₁ ₂), where Brel = Eq | Ne | Gt | Ge | Lt | Le | Ueq | Une.
	 In Z3 we don't have some of that, let's postpone deciding what to do there;
	 it should never happen if callers check for isPNot first."
	^false
]

{ #category : #'*Refinements' }
Z3Node >> isPExist [
	"Answer whether Fixpoint would consider this node a PExist."
	^false
]

{ #category : #'*Refinements' }
Z3Node >> isPIff [
	"Answer whether Fixpoint would consider this node a PIff."
	^false
]

{ #category : #'*Refinements' }
Z3Node >> isPImp [
	"Answer whether Fixpoint would consider this node a PImp."
	^false
]

{ #category : #'*Refinements' }
Z3Node >> isPNot [
	"Answer whether Fixpoint would consider this node a PNot."
	^false
]

{ #category : #'*Refinements' }
Z3Node >> isPOr [
	"Answer whether Fixpoint would consider this node a POr."
	^false
]

{ #category : #'*Refinements' }
Z3Node >> kvarsExpr [
	^#()
]

{ #category : #'*Refinements' }
Z3Node >> mapExprOnExpr: _ [ 
	^self
]

{ #category : #'*Refinements' }
Z3Node >> mapExprOnExpr_case: _ [ 
	^self
]

{ #category : #'*Refinements' }
Z3Node >> smt2Cast: aZ3Sort in: _ [
	aZ3Sort = self sort ifFalse: [ self error ].
	^self
]

{ #category : #'*Refinements' }
Z3Node >> sortExpr: γ [
	| f |
	f := γ standardLookupSEnv.
	[ ^self checkExpr: f ] runCM0
]

{ #category : #'*Refinements' }
Z3Node >> subst: aSubst [
	aSubst isEmpty ifTrue: [^self].
	^self inEnvironment: aSubst
]

{ #category : #'*Refinements' }
Z3Node >> toZ3Node [
	^self

]
