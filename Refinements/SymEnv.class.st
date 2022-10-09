"
--------------------------------------------------------------------------------
-- | 'SymEnv' is used to resolve the 'Sort' and 'Sem' of each 'Symbol'
--------------------------------------------------------------------------------
data SymEnv = SymEnv {
seSort    :: !(SEnv Sort)              -- ^ Sorts of *all* defined symbols
seTheory  :: !(SEnv TheorySymbol)      -- ^ Information about theory-specific Symbols
seData    :: !(SEnv DataDecl)          -- ^ User-defined data-declarations
seLits    :: !(SEnv Sort)              -- ^ Distinct Constant symbols
seAppls   :: !(M.HashMap FuncSort Int) -- ^ Types at which `apply` was used;
                                          --   see [NOTE:apply-monomorphization]
}
"
Class {
	#name : #SymEnv,
	#superclass : #Object,
	#instVars : [
		'sort',
		'theory',
		'data',
		'lits',
		'appls'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
SymEnv class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
SymEnv class >> sort:s theory:th data:d lits:l appls:a [
	^self basicNew
		sort:s;
		theory:th;
		data:d;
		lits:l;
		appls:a;
		yourself
]

{ #category : #'instance creation' }
SymEnv class >> xEnv: xEnv fEnv: fEnv ds: ds ls: ls ts: ts [
"
symEnv :: SEnv Sort -> SEnv TheorySymbol -> [DataDecl] -> SEnv Sort -> [Sort] -> SymEnv
"
	^self basicNew "BOGUS: for now, the bare minimum we can get away with"
		sort: xEnv;
		"theory: ?;
		data: ?;
		lits: ?;
		appls: ?;"
		yourself
]

{ #category : #'as yet unclassified' }
SymEnv >> , y [
self shouldBeImplemented .
	^SymEnv new "BOGUS, SymEnvs aren't there at all yet"
]

{ #category : #accessing }
SymEnv >> appls [
	^ appls
]

{ #category : #accessing }
SymEnv >> appls: anObject [
	appls := anObject
]

{ #category : #'as yet unclassified' }
SymEnv >> createSolution_kGs: kGs kXs: kXs kYs: kYs z: z ebs: ebs xbs: xbs [
"
Create a Solution.
fromList :: SymEnv
         -> [(KVar, a)]
         -> [(KVar, b)]
         -> [(KVar, Hyp)]
         -> M.HashMap KVar IBindEnv
         -> [(BindId, EbindSol)]
         -> SEnv (BindId, Sort)
         -> Sol a b
"
	^Solution basicNew
		sEnv: self;
		sMap: kGs;
		gMap: kXs;
		sHyp: kYs;
		sScp: z;
		sEbd: ebs;
		sxEnv: xbs;
		yourself
]

{ #category : #accessing }
SymEnv >> data [
	^ data
]

{ #category : #accessing }
SymEnv >> data: anObject [
	data := anObject
]

{ #category : #GT }
SymEnv >> gtInspectorSortsIn: composite [
	<gtInspectorPresentationOrder: 1>
	^(sort gtInspectorItemsIn: composite) title: 'Sorts'
]

{ #category : #accessing }
SymEnv >> lits [
	^ lits
]

{ #category : #accessing }
SymEnv >> lits: anObject [
	lits := anObject
]

{ #category : #'as yet unclassified' }
SymEnv >> makeContextWithSEnv [
	"This is where the SMT context is created in Liquid.
	All we need in Smalltalk is the env"
	^self
]

{ #category : #accessing }
SymEnv >> sort [
	^ sort
]

{ #category : #accessing }
SymEnv >> sort: anObject [
	sort := anObject
]

{ #category : #'as yet unclassified' }
SymEnv >> substElim: sEnv combEnv: g kVar: __ subst: su [
"
Return the binders that must be existentially quantified,
       and the equality predicate relating the kvar-'parameters' and their
       actual values. i.e. given
  
          K[x1 := e1]...[xn := en]
  
       where e1 ... en have types t1 ... tn
       we want to quantify out
  
         x1:t1 ... xn:tn
  
       and generate the equality predicate && [x1 ~~ e1, ... , xn ~~ en]
       we use ~~ because the param and value may have different sorts, see:
  
          tests/pos/kvar-param-poly-00.hs
  
       Finally, we filter out binders if they are
  
       1. 'free' in e1...en i.e. in the outer environment.
          (Hmm, that shouldn't happen...?)
  
       2. are binders corresponding to sorts (e.g. `a : num`, currently used
          to hack typeclasses current.)
substElim :: F.SymEnv -> F.SEnv F.Sort -> CombinedEnv -> F.KVar -> F.Subst -> ([(F.Symbol, F.Sort)], F.Pred)
"
	| m conjuncts xts |
	"bgs: NB: this works quite differently in Smalltalk
	because at this point we are dealing with Z3 ASTs already compiled.
	For now, start with the simplest thing we can get away with."
	m := su list.
	conjuncts := m collect: [ :eachSubstAss |
		| x e |
		x := (FxEVar of: eachSubstAss key) evaluateIn: g bEnv evalEnv.
		e := eachSubstAss value evaluateIn: g bEnv evalEnv.
		x === e ].
	xts := m collect: [ :eachSubstAss | (FxEVar of: eachSubstAss key) evaluateIn: g bEnv evalEnv ].
	^{ xts . Bool and: conjuncts }
]

{ #category : #accessing }
SymEnv >> theory [
	^ theory
]

{ #category : #accessing }
SymEnv >> theory: anObject [
	theory := anObject
]
