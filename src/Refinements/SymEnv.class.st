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
		'appls',
		'naturalTransformations'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
SymEnv class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
SymEnv class >> sort: xEnv theory: fEnv data: dEnv lits: ls appls: sortMap [
	^self basicNew
		sort: xEnv;
		theory: fEnv;
		data: dEnv;
		lits: ls;
		appls: sortMap;
		yourself
]

{ #category : #'instance creation' }
SymEnv class >> xEnv: xEnv fEnv: fEnv ds: ds ls: ls ts: ts [
"
symEnv :: SEnv Sort -> SEnv TheorySymbol -> [DataDecl] -> SEnv Sort -> [Sort] -> SymEnv
             xEnv         fEnv                 ds           ls           ts
Cf. Types/Theories.hs
"
	| xEnv′ dEnv sortMap |
	"BOGUS: for now, the bare minimum we can get away with"
	xEnv′ := xEnv "unionSEnv xEnv wiredInEnv".
	dEnv := SEnv newFromAssociations: ( ds collect: [ :d | d symbol -> d ] ).
	^SymEnv sort: xEnv′ theory: fEnv data: dEnv lits: ls appls: sortMap  "sortMap is at this time out of necessity BOGUS because ts is bogus"
]

{ #category : #Semigroup }
SymEnv >> , y [
	^self copy
		sort: sort, y sort;
		naturalTransformations: self naturalTransformations, y naturalTransformations;
		yourself
]

{ #category : #accessing }
SymEnv >> appls [
	^ appls
]

{ #category : #accessing }
SymEnv >> appls: anObject [
	appls := anObject
]

{ #category : #accessing }
SymEnv >> at: x insert: t [ 
"
insertSymEnv :: Symbol -> Sort -> SymEnv -> SymEnv
insertSymEnv x t env = env { seSort = insertSEnv x t (seSort env) }
"
	^self copy
		sort: (sort at: x insert: t);
		yourself
]

{ #category : #copying }
SymEnv >> copy [
	^super copy
		sort: sort copy;
		yourself
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
	<gtInspectorPresentationOrder: 71>
	^ composite fastTable
		title: 'Sorts';
		display: [ sort associations ];
		column: 'Var'  evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Sort' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ]
]

{ #category : #accessing }
SymEnv >> lits [
	^ lits
]

{ #category : #accessing }
SymEnv >> lits: anObject [
	lits := anObject
]

{ #category : #'SMT interface' }
SymEnv >> makeContextWithSEnv [
"
makeContextWithSEnv :: Config -> FilePath -> SymEnv -> IO Context
                        cfg          f      env=self
Here our Smalltalk implementation differs from upstream FX, we in-process call libz3 over FFI.
"
	^SMTContext with: self
]

{ #category : #'natural transformations' }
SymEnv >> naturalTransformationFor: functionName [ 
	^self naturalTransformations at: functionName ifAbsentPut: [ (sort at: functionName) toNaturalTransformationNamed: functionName ]
]

{ #category : #accessing }
SymEnv >> naturalTransformations [
	naturalTransformations isNil ifTrue: [ naturalTransformations := Dictionary new ].
	^ naturalTransformations
]

{ #category : #accessing }
SymEnv >> naturalTransformations: anObject [
	naturalTransformations := anObject
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
	m := su associations.
	conjuncts := m collect: [ :eachSubstAss |
		| x e |
		x := (EVar of: eachSubstAss key) evaluateIn: g bEnv evalEnv.
		e := eachSubstAss value evaluateIn: g bEnv evalEnv.
		x === e ].
	xts := m collect: [ :eachSubstAss | (EVar of: eachSubstAss key) evaluateIn: g bEnv evalEnv ].
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

{ #category : #'as yet unclassified' }
SymEnv >> withAllSorts: sEnv′ [ 
	^self copy
		sort: sort, sEnv′;
		yourself
]
