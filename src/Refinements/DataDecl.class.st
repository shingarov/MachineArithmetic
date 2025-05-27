"
data DataDecl = DDecl
  { ddTyCon :: !FTycon            -- ^ Name of defined datatype
  , ddVars  :: !Int               -- ^ Number of type variables
  , ddCtors :: [DataCtor]         -- ^ Datatype Ctors. Invariant: type variables bound in ctors are greater than ddVars
  } deriving (Eq, Ord, Show, Data, Typeable, Generic)

=== Cf. Theories.hs: ===
| [NOTE:DataDecl]  This note explains the set of symbols generated
     for the below data-declaration:

  data Vec 1 = [
    | nil  { }
    | cons { vHead : @(0), vTail : Vec}
  ]

We call 'Vec' the _self-sort_ of the data-type, and we want to ensure that
in all constructors, tests and selectors, the _self-sort_ is replaced with
the actual sort, namely, 'Vec @(0)'.

Constructors  // ctor : (fld-sorts) => me

        nil   : func(1, [Vec @(0)])
        cons  : func(1, [@(0); Vec @(0); Vec @(0)])

Tests         // is#ctor : (me) => bool

      is#nil  : func(1, [Vec @(0); bool])
      is#cons : func(1, [Vec @(0); bool])

Selectors     // fld : (me) => fld-sort

      vHead   : func(1, [Vec @(0); @(0)])
      vTail   : func(1, [Vec @(0); Vec @(0)])
"
Class {
	#name : #DataDecl,
	#superclass : #Object,
	#instVars : [
		'ddTyCon',
		'ddVars',
		'ddCtors'
	],
	#category : #'Refinements-Sorts'
}

{ #category : #'instance creation' }
DataDecl class >> ddTyCon: ddTyCon ddVars: ddVars ddCtors: ddCtors [
	^self basicNew
		ddTyCon: ddTyCon;
		ddVars: ddVars;
		ddCtors: ddCtors;
		yourself 
	
]

{ #category : #theories }
DataDecl class >> theorify: anAssociation [
"
-- | 'theorify' converts the 'Sort' into a full 'TheorySymbol'
theorify :: (Symbol, Sort) -> (Symbol, TheorySymbol)
"
	| x t |
	x := anAssociation key.  t := anAssociation value.
	^x -> (TheorySymbol
		tsSym: x
		tsRaw: x symbolRaw
		tsSort: t
		tsInterp: SemField
	)
]

{ #category : #theories }
DataDecl class >> theorySymbols: ds [
"
-- | `theorySymbols` contains the list of ALL SMT symbols with interpretations,
--   i.e. which are given via `define-fun` (as opposed to `declare-fun`)
theorySymbols :: [DataDecl] -> SEnv TheorySymbol -- M.HashMap Symbol TheorySymbol
theorySymbols ds = fromListSEnv $  -- SHIFTLAM uninterpSymbols
                                  interpSymbols
                               ++ concatMap dataDeclSymbols ds
"
	^SEnv newFromAssociations: (
		TheorySymbol interpSymbols,
		(ds >>= #dataDeclSymbols)
	)
]

{ #category : #construction }
DataDecl >> addToQuery: aNNFQuery [ 
	aNNFQuery qData add: self
]

{ #category : #'SMT interface' }
DataDecl >> apply: ts [
	"Given type-parametrized receiver ...@(0)...@(1)...,
	 and actual type parameters t₀, t₁, …, answer a DataDecl with
	 all formal type parameters substituted: ...t₀...t₁... ." 
	^DataDecl
		ddTyCon: (ddTyCon apply: ts)
		ddVars: 0
		ddCtors: (ddCtors collect: [ :ctor | ctor apply: ts])
]

{ #category : #theories }
DataDecl >> ctorSymbols [
"
ctorSymbols :: DataDecl -> [(Symbol, TheorySymbol)]
"
	^ddCtors collect: [ :ctor | ctor ctorSort: self ]
]

{ #category : #theories }
DataDecl >> dataDeclSymbols [
"
--------------------------------------------------------------------------------
-- | Constructors, Selectors and Tests from 'DataDecl'arations.
--------------------------------------------------------------------------------
dataDeclSymbols :: DataDecl -> [(Symbol, TheorySymbol)]
dataDeclSymbols d = ctorSymbols d ++ testSymbols d ++ selectSymbols d
"
	^self ctorSymbols, self testSymbols, self selectSymbols
]

{ #category : #accessing }
DataDecl >> ddCtors [
	^ ddCtors
]

{ #category : #accessing }
DataDecl >> ddCtors: anObject [
	ddCtors := anObject
]

{ #category : #accessing }
DataDecl >> ddTyCon [
	^ ddTyCon
]

{ #category : #accessing }
DataDecl >> ddTyCon: anObject [
	ddTyCon := anObject
]

{ #category : #accessing }
DataDecl >> ddVars [
	^ ddVars
]

{ #category : #accessing }
DataDecl >> ddVars: anObject [
	ddVars := anObject
]

{ #category : #GT }
DataDecl >> gtInspectorConstructorsIn: composite [
	<gtInspectorPresentationOrder: 40>
	^ composite fastList
		title: 'Constructors';
		display: [ ddCtors ]
]

{ #category : #'SMT interface' }
DataDecl >> monomorphicDeclIn: γ [
	| known |
	known := [ Context readState: #knownMonomorphizedDecls ]
		on: NoAnswer
		do: [ :_ex | [ ^self monomorphicDeclIn: γ ] runReader: #knownMonomorphizedDecls initialState: Dictionary new ].
	^known
		at: ddTyCon symbol
		ifAbsentPut: [
			| mdd |
			mdd := MonomorphizedDataDecl named: ddTyCon symbol encodeUnsafe.
			known at: ddTyCon symbol put: mdd.
			ddCtors do: [ :ctor | ctor declare: mdd in: γ ].
			mdd
		]


	
]

{ #category : #printing }
DataDecl >> printOn: aStream [
	aStream nextPutAll: 'data '.
	aStream nextPutAll: self ddTyCon symbol
]

{ #category : #theories }
DataDecl >> selectSymbols [
"
selectSymbols :: DataDecl -> [(Symbol, TheorySymbol)]
"
	^ddCtors >>= (□ ctorSelectors: self) collect: (DataDecl theorify: □)
]

{ #category : #theories }
DataDecl >> selfSort [
"
See [NOTE:DataDecl] for details.
"

"selfSort (DDecl c n _) = fAppTC c (FVar <$> [0..(n-1)])
                 ↑ ↑
                 | ddVars
                 ddTyCon
"
	^ddTyCon fAppTC: ((0 to: ddVars-1) collect: (FVar new: □))
]

{ #category : #Symbolic }
DataDecl >> symbol [
"
instance Symbolic DataDecl where
  symbol = symbol . ddTyCon
"
	^ddTyCon symbol
]

{ #category : #theories }
DataDecl >> testSymbols [
"
testSymbols :: DataDecl -> [(Symbol, TheorySymbol)]
"
	| t |
	t := Z3Sort mkFFunc: ddVars sorts: { self selfSort . Z3Sort bool }.
	^ddCtors collect: [ :ctor | t testTheory: ctor symbol ]
]

{ #category : #'SMT interface' }
DataDecl >> z3sort: γ [
	ddVars = 0 ifFalse: [ self error ].
	^PreSort hotel
		at: ddTyCon symbol
		ifAbsentPut: [ (self monomorphicDeclIn: γ) create ]
]
