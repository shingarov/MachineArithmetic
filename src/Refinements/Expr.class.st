"
data Expr = ESym !SymConst
          | ECon !Constant
          | EVar !Symbol
          | EApp !Expr !Expr
          | ENeg !Expr
          | EBin !Bop !Expr !Expr
          | EIte !Expr !Expr !Expr
          | ECst !Expr !Sort
          | ELam !(Symbol, Sort)   !Expr
          | ETApp !Expr !Sort 
          | ETAbs !Expr !Symbol 
          | PAnd   ![Expr]
          | POr    ![Expr] 
          | PNot   !Expr
          | PImp   !Expr !Expr
          | PIff   !Expr !Expr
          | PAtom  !Brel  !Expr !Expr
          | PKVar  !KVar !Subst
          | PAll   ![(Symbol, Sort)] !Expr
          | PExist ![(Symbol, Sort)] !Expr
          | PGrad  !KVar !Subst !GradInfo !Expr
          | ECoerc !Sort !Sort !Expr  
          deriving (Eq, Show, Ord, Data, Typeable, Generic)
"
Class {
	#name : #Expr,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #constants }
Expr class >> PFalse [
	^POr of: #()
]

{ #category : #constants }
Expr class >> PTrue [
	^PAnd of: #()
]

{ #category : #'instance creation' }
Expr class >> new [
"
instance Monoid Expr where
  mempty  = PTrue
"
	^Expr PTrue
]

{ #category : #'as yet unclassified' }
Expr class >> splitEApp: e [
	| go |	
	go := [ :acc :thisTime |
		(thisTime isKindOf: EApp)
			ifTrue: [ go value: ({thisTime imm}, acc) value: thisTime expr ]
			ifFalse: [ thisTime->acc ] ].
	^go value: #() value: e

]

{ #category : #'theory symbols' }
Expr >> & anotherPred [ 
	^PAnd of: { self . anotherPred }
]

{ #category : #'theory symbols' }
Expr >> + rhs [
	^EBin
		bop: #+
		left: self
		right: rhs
]

{ #category : #'theory symbols' }
Expr >> - rhs [
	^ECst
		expr: (EMessageSend of: (MessageSend receiver: self selector: #- argument: rhs))
		sort: Int sort
]

{ #category : #'theory symbols' }
Expr >> < rhs [
	^ECst
		expr: (EBin bop: #< left: self right: rhs)
		sort: Bool sort
]

{ #category : #'theory symbols' }
Expr >> <+ rhs [
	^ECst
		expr: (EBin bop: #<+ left: self right: rhs)
		sort: Bool sort
]

{ #category : #'theory symbols' }
Expr >> <= rhs [
	^ECst
		expr: (EBin bop: #<= left: self right: rhs)
		sort: Bool sort
]

{ #category : #'theory symbols' }
Expr >> <=> rhs [
	^ECst
		expr: (EMessageSend of: (MessageSend receiver: self selector: #<=> argument: rhs))
		sort: Bool sort
]

{ #category : #'theory symbols' }
Expr >> === rhs [
	^ECst
		expr: (PAtom brel: #=== x: self y: rhs)
		sort: Bool sort
]

{ #category : #'theory symbols' }
Expr >> > rhs [
	^ECst
		expr: (EBin bop: #> left: self right: rhs)
		sort: Bool sort
]

{ #category : #'theory symbols' }
Expr >> >= rhs [
	^ECst
		expr: (EBin bop: #> left: self right: rhs)
		sort: Bool sort
]

{ #category : #visiting }
Expr >> accept: aVisitor [
	self subclassResponsibility
]

{ #category : #'theory symbols' }
Expr >> adaptToBitVector: receiver length: length andSend: selector [
	^ECst
		expr: (EMessageSend of: (MessageSend
			receiver: (receiver toBitVector: length)
			selector: selector
			argument: self))
		sort: (Z3Sort bv: length)
]

{ #category : #'theory symbols' }
Expr >> adaptToBool: receiver andSend: selector [
	(PAtom normalizeBrelSelector: selector) ifNotNil: [ :s |
		^ECst
			expr: (PAtom  brel: s x: receiver y: self)
			sort: Bool sort
	].
	(EBin normalizeBopSelector: selector) ifTrue: [ :s |
		^self shouldBeImplemented
	].
	^self shouldBeImplemented
]

{ #category : #'theory symbols' }
Expr >> adaptToInt: receiver andSend: selector [
	(PAtom normalizeBrelSelector: selector) ifNotNil: [ :s |
		^ECst
			expr: (PAtom brel: s x: receiver y: self)
			sort: Bool sort
	].
	(EBin normalizeBopSelector: selector) ifNotNil: [ :s |
		^ECst
			expr: (EBin bop: selector left: receiver right: self)
			sort: Int sort
	].
	^self shouldBeImplemented
]

{ #category : #'theory symbols' }
Expr >> adaptToInteger: receiver andSend: selector [
	(PAtom normalizeBrelSelector: selector) ifNotNil: [ :s |
		^self shouldBeImplemented
	].
	(EBin normalizeBopSelector: selector) ifNotNil: [ :s |
		^ECst
			expr: (EBin bop: s left: receiver toInt right: self)
			sort: Int sort
	].
	^self shouldBeImplemented
	
]

{ #category : #'theory symbols' }
Expr >> add: rhs [
	^ECst
		expr: (EMessageSend of: (MessageSend receiver: self selector: #add: argument: rhs))
		sort: Int sort
]

{ #category : #sanitizing }
Expr >> badArg: sEnv [
 
	self shouldBeImplemented.
]

{ #category : #'sort-checking' }
Expr >> checkCst: t inEnv: f [
"
-- | Helper for checking cast expressions 
checkCst :: Env -> Sort -> Expr -> CheckM Sort
"
"
checkCst f t e = …
"
	| t′ |
	t′ := self checkExpr: f.
	^(f unifys: self ts: {t} ts′: {t′}) applyTo: t 
]

{ #category : #GT }
Expr >> children [
	^#()
]

{ #category : #logic }
Expr >> conjuncts [
	self isTautoPred ifTrue: [ ^#() ].
	^{self}
]

{ #category : #elaboration }
Expr >> defuncEApp: es env: γ [
	"Only Exprs of the form ECst(EVar) can be defunctionalized."
	self shouldNotImplement
]

{ #category : #'sort-checking' }
Expr >> eCstAtom: t inElabEnv: _ [
"
-- | 'eCstAtom' is to support tests like `tests/pos/undef00.fq`
eCstAtom :: ElabEnv -> Expr -> Sort -> CheckM Expr
Cf. SortCheck.hs
"
	^ECst expr: self sort: t
]

{ #category : #elaboration }
Expr >> elab: anElabEnv [
"
-- | Elaborate expressions with types to make polymorphic instantiation explicit.
elab :: ElabEnv -> Expr -> CheckM (Expr, Sort)

NB: This superclass-implementation is peculiar to Smalltalk:
we delegate elab'ing of DecidableRefinements and molecules built from them,
to #evaluateIn:, so something like '(a===b) not' is compiled to that Smalltalk
expression (and later at the end of #elaborate: to the Z3 AST '¬(a=b)'),
not going through PNot.
"
	| evalEnv computed |
	evalEnv := EvalEnv ofSorts: anElabEnv senv sort.
	computed := self evaluateIn: evalEnv.
	^computed elab: anElabEnv
]

{ #category : #elaboration }
Expr >> elabApply: γ [
"
LiquidFixpoint replaces all direct function calls
with indirect calls via `apply`:
cf. SortCheck.hs
elabApply :: SymEnv -> Expr -> Expr

In contrast, MachineArithmetic does not have 'apply' functions;
instead, we collect the instances of the polymorphic type in a
'Hotel of sorts' as explained in FAST-WS'22.

When control reaches this point, we are elaborating one particular
instance of the polymorphic type, and every node is wrapped in
a ECst fully monomorphized for that instance.
If the self node is an app, we create and return the corresponding
UncurriedApp.
For example, in L₆>>maxint, (papp1 p |vº2ºº3|) returns a 𝔹.
Here p is a (FApp FTC (TC Pred) ℤ), v is a ℤ, and papp1 takes a
ℤ→𝔹 and a ℤ and returns a 𝔹 (by applying p to v).
splitArgs splits the (papp1 p |vº2ºº3|) into f, which is «papp1»
cast to (Pred ℤ)→ℤ→𝔹 (NB the ECst's sort is still in higher-order
form); and es which is array of associations from arg to result-
type of each currying step: in our example, es[2] corresponds to
the final ℤ→𝔹 and goes from ⟬ℤ⟭v to 𝔹, and es[1] goes from ⟬Pred ℤ)⟭p
to ℤ→𝔹.
"
	| go |
	go := [ :e |
			| f_args f es |
			f_args := e splitArgs.  f := f_args key.  es := f_args value.
			es isEmpty
				ifTrue: [ f elabApplyStep: γ ]
				ifFalse: [
						| es′ |
						"recursively elabApply children..."
						es′ := es collectAssociations: [ :eachArg :argSort | (go value: eachArg) -> argSort ].
						"...and defunctionalize to UncurriedApp"
						(go value: f) defuncEApp: es′ env: γ ] ].
	^go value: self
]

{ #category : #elaboration }
Expr >> elabApplyStep: γ [
	"The inner 'step' function in elabApply (SortCheck.hs)."
	^self subclassResponsibility
]

{ #category : #'sort-checking' }
Expr >> elabAs: t inElabEnv: f [
"
elabAs :: ElabEnv -> Sort -> Expr -> CheckM Expr
             f        t      self
"
	^(self elab: f) first
]

{ #category : #elaboration }
Expr >> elabExpr: aSymEnv [
"
Add casts to decorate polymorphic instantiation sites.
elabExpr :: Located String -> SymEnv -> Expr -> Expr
Nobody settles in the hotel just yet.
" 
	^self elabExprE: aSymEnv
]

{ #category : #elaboration }
Expr >> elabExprE: env [
"
elabExprE :: Located String -> SymEnv -> Expr -> Either Error Expr
"
	| sEnv f s |
	sEnv := env sort.
	f := sEnv standardLookupSEnv.
	s := [ self elab: (ElabEnv symEnv: env env: f) ] runCMwithIncrement: 0.
	^s first

]

{ #category : #Elaborate }
Expr >> elaborate: γ [
"
class Elaborate a where 
  elaborate :: Located String -> SymEnv -> a -> a
instance Elaborate Expr where
  elaborate msg env = elabNumeric . elabApply env . elabExpr msg env

Note that this composition is applied from the level of each rhs expression
in every SimpC.
"
	^(self elabExpr: γ)
		elabApply: γ
]

{ #category : #'term rewriting' }
Expr >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
	self subclassResponsibility
]

{ #category : #Expression }
Expr >> expr [
"
instance Expression Expr where
  expr = id
"
	^self
]

{ #category : #Transformations }
Expr >> flatten [
"
instance Flatten F.Expr
"
	^self
]

{ #category : #'as yet unclassified' }
Expr >> hasKVars [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
Expr >> ifThen: thenE else: elseE [
	^EIte
		if: self
		then: thenE
		else: elseE
]

{ #category : #'theory symbols' }
Expr >> includes: rhs [
	^ECst
		expr: (EMessageSend of: (MessageSend receiver: self selector: #includes: argument: rhs))
		sort: Bool sort
]

{ #category : #'as yet unclassified' }
Expr >> isConc [
	"note: this should be combined with PKVar>>isConc"
	^self kvarsExpr isEmpty
]

{ #category : #'as yet unclassified' }
Expr >> isConstantNamed: s [ 
	^false
]

{ #category : #'theory symbols' }
Expr >> isEmptySet [
	^ECst
		expr: (EMessageSend of: (MessageSend receiver: self selector: #isEmptySet))
		sort: Bool sort
]

{ #category : #testing }
Expr >> isKVar [
	^false
]

{ #category : #'as yet unclassified' }
Expr >> isSingletonExpr: v in: env [
"isSingletonExpr :: Symbol -> Expr -> Maybe Expr.
The selector is misleading, but let's keep it for now for consistency with LF.
NB: the returned expression isn't necessary an EVar, it can be any Z3 AST.
"
	| ast |
	ast := self evaluateIn: env.
	^ast singletonExpr: v
]

{ #category : #logic }
Expr >> isTautoPred [
	^false
]

{ #category : #'as yet unclassified' }
Expr >> kvarsExpr [
	"BOGUS.  For now let's assume only literally RefVarApps have kappas."
	^#()
]

{ #category : #logic }
Expr >> not [
	^PNot of: self
]

{ #category : #Predicate }
Expr >> prop [
"
instance Predicate Expr where
  prop = id
"
	^self
]

{ #category : #logic }
Expr >> refaConjuncts [
"
refaConjuncts :: Expr -> [Expr]
refaConjuncts p = [p' | p' <- conjuncts p, not $ isTautoPred p']
"
	^self conjuncts reject: #isTautoPred
]

{ #category : #logic }
Expr >> reft: v [
"
reft :: Symbol -> Expr -> Reft
reft v p = Reft (v, p)
cf. Refinements.hs
"
	^Reft symbol: v expr: self
]

{ #category : #'α-renaming' }
Expr >> rename: a to: b [
	^DelayedSubst from: a toVar: b in: self
]

{ #category : #'SMT interface' }
Expr >> smt2: γ [
	self shouldNotImplement
]

{ #category : #'SMT interface' }
Expr >> smt2Cast: _ in: γ [
"
smt2Cast :: SymEnv -> Expr -> Sort -> Builder.Builder
"
	^self smt2: γ
]

{ #category : #'as yet unclassified' }
Expr >> splitArgs [
"
splitArgs :: Expr -> (Expr, [(Expr, Sort)])
"
	| go |
	go := [ :acc :yy |
		((yy isKindOf: ECst) and: [ yy expr isKindOf: EApp ])
			ifTrue: [
				| e1 e s |
				e1 := yy expr expr.
				e  := yy expr imm.
				s := yy sort.
				go value: {e->s}, acc value: e1
			] ifFalse: [
				(yy isKindOf: EApp) ifTrue: [ self error ].
				yy -> acc
	  ] ].
	
	^go value: #() value: self
]

{ #category : #'F.Subable' }
Expr >> subst: su [
	^DelayedSubst subst: su in: self
]

{ #category : #'F.Subable' }
Expr >> syms [
	self shouldBeImplemented
]

{ #category : #logic }
Expr >> toHCstr [
	^self cHead
]

{ #category : #'theory symbols' }
Expr >> without: rhs [
	^ECst
		expr: (EMessageSend of: (MessageSend receiver: self selector: #without: argument: rhs))
		sort: rhs sort mkSetSort
]

{ #category : #'theory symbols' }
Expr >> | rhs [ 
	^POr of: { self . rhs }
]

{ #category : #'theory symbols' }
Expr >> ∪ [ rhs
	^ECst
		expr: (EMessageSend of: (MessageSend receiver: self selector: #∪ argument: rhs))
		sort: Int sort
]
