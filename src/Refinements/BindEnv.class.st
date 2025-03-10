"
-- Invariant: All BindIds in the map are less than beSize
type BindEnv       = SizedEnv (Symbol, SortedReft)

Cf. Types/Environments.hs
"
Class {
	#name : #BindEnv,
	#superclass : #SizedEnv,
	#category : #'Refinements-Environments'
}

{ #category : #'instance creation' }
BindEnv class >> bindEnvFromList: bs [
"
bindEnvFromList :: [(BindId, Symbol, SortedReft)] -> BindEnv
Cf. Environments.hs
"
	| be maxId |
	bs isEmpty ifTrue: [ ^self emptyBindEnv ].
	be := bs collect: [ :b | b int -> (b symbol -> b sortedReft) ].
	be := BindMap newFromAssociations: be.
	maxId := (bs collect: #int) max.
	^BindEnv size: 1+maxId binds: be
]

{ #category : #'instance creation' }
BindEnv class >> emptyBindEnv [
	^self size: 0 binds: BindMap new
]

{ #category : #'instance creation' }
BindEnv class >> fromListBindEnv: xs [
"
fromListBindEnv :: [(BindId, (Symbol, SortedReft))] -> BindEnv
"
	^self
		size: xs size
		binds: "(M.fromList xs)" xs shouldBeImplemented
]

{ #category : #visiting }
BindEnv >> accept: aVisitor [
	^BindEnv
		size: _beSize
		binds: (beBinds collect: [ :x_sr |
				| x sr |
				x := x_sr key.  sr := x_sr value.
				x -> (sr accept: aVisitor) ])
]

{ #category : #accessing }
BindEnv >> bindEnvToList [
"
bindEnvToList :: BindEnv -> [(BindId, Symbol, SortedReft)]
                (BE _ be)
"
	^beBinds associations collect: [ :ass | {ass key . ass value key . ass value value} ]
]

{ #category : #sanitizing }
BindEnv >> binders [
"
binders :: F.BindEnv -> [(F.Symbol, (F.Sort, F.BindId))]
"
	^self bindEnvToList collectTriples: [ :i :x :t | x -> (t sr_sort -> i) ]
]

{ #category : #compilation }
BindEnv >> compileIn: γ [
	"Destructive. Peculiar to Smalltalk."
	beBinds := beBinds collect: [ :var_sr |
		| var sr θ |
		var := var_sr key.
		sr := var_sr value.
		θ := Subst mkSubstNameToName: { sr sr_reft symbol -> var }.
		var -> (sr evaluateIn: (γ amendedBy: θ)) ]
]

{ #category : #logic }
BindEnv >> concretePreds [
	| concreteIndexDict compiledPreds |
	concreteIndexDict := beBinds select: [ :s_r | s_r value sr_reft expr isBool ].
	compiledPreds := concreteIndexDict collect: [ :s_r |
		| r |
		r := s_r value.
		r sr_reft expr ].
	^compiledPreds reject: #isShortExpr
]

{ #category : #solution }
BindEnv >> cstrDef: aSimpC [
"cstrDef :: F.BindEnv -> F.SimpC a -> Maybe F.Symbol"
	| v__ v rhs e sym |
	v__ := self lookupBindEnv: aSimpC cbind.
	v := v__ key.
	rhs := aSimpC crhs "stripCasts  - BOGUS".
	e := rhs isSingletonExpr: v  in: self evalEnv.
	e isNil ifTrue: [ ^nil ].
	e isNamedConstant ifFalse: [ ^nil ].
	sym := e functorName.
	sym = 'true' ifTrue: [ ^nil ].
	sym = 'false' ifTrue: [ ^nil ].
	^sym
]

{ #category : #logic }
BindEnv >> domain: aWfC [ 
"
domain :: BindEnv -> WfC a -> [Symbol]
"
	^{aWfC rft first},
	 ((self envCs: aWfC env) collect: #key) asArray
]

{ #category : #Elaborate }
BindEnv >> elaborate: γ [
"
NB: In Smalltalk, this is destructive.
instance Elaborate BindEnv where
  elaborate z env = mapBindEnv (\i (x, sr) -> (x, elaborate (z' i x sr) env sr))
    where
      z' i  x sr  = z { val = (val z) ++ msg i x sr }
      msg i x sr  = unwords [' elabBE',  show i, show x, show sr]
"

	self mapBindEnv: [ :i :x_sr |
		| x sr |  x := x_sr key. sr := x_sr value.
		x -> (sr elaborate: γ) ]
]

{ #category : #logic }
BindEnv >> envCs: anIBindEnv [
"
envCs :: BindEnv -> IBindEnv -> [(Symbol, SortedReft)]
          self         env
Cf. Types/Environments.hs
"
	^anIBindEnv elemsIBindEnv collect: [ :i | self lookupBindEnv: i ]
]

{ #category : #visiting }
BindEnv >> envKVars: c [
"
envKVars :: (TaggedC c a) => BindEnv -> c a -> [KVar]
"
	^(
	(c clhs: self) >>= [ :ass |
		| sr |
		sr := ass value.
		sr sr_reft expr kvarsExpr ]
	) asSet asArray
]

{ #category : #compilation }
BindEnv >> evalEnv [
"TODO: re-express in terms of symBinds/bindSorts, because of uninterpreted functions --- done?? see the commented bogusLits"
	^EvalEnv ofSorts: self sortDict
]

{ #category : #GT }
BindEnv >> gtInspectorBindsIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite fastTable
		title: 'Binds';
		display: [ beBinds associations ];
			column: 'Index' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Bind' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ]
]

{ #category : #updating }
BindEnv >> insertBE: xt [
"
insertBE :: F.BindEnv -> (F.Symbol, F.Sort) -> (F.BindEnv, F.BindId)
Cf. Horn/Info.hs
"
	| x t |
	x := xt key. t := xt value.
	^(self insertBindEnv: x sortedReft: t trueSortedReft) swap
]

{ #category : #updating }
BindEnv >> insertBindEnv: x sortedReft: r [
"
insertBindEnv :: Symbol -> SortedReft -> BindEnv -> (BindId, BindEnv)
insertBindEnv x r (BE n m) = (n, BE (n + 1) (M.insert n (x, r) m))
"
	| n m |
	n := _beSize.  m := beBinds.
	^n -> (BindEnv
		size: n+1
		binds: (m insert: x->r at: n)
	)
]

{ #category : #accessing }
BindEnv >> lookupBindEnv: k [
"
lookupBindEnv :: BindId -> BindEnv -> (Symbol, SortedReft)
                  k       (BE _ m)
"
	^beBinds
		at: k
		ifAbsent: [ self error: 'lookupBindEnv: cannot find binder ', k printString ]
]

{ #category : #visiting }
BindEnv >> mapBindEnv: f [
"
mapBindEnv :: (BindId -> (Symbol, SortedReft) -> (Symbol, SortedReft)) -> BindEnv -> BindEnv
mapBindEnv f (BE n m) = BE n $ M.mapWithKey f m
Cf. Environments.hs
In Smalltalk we destructively replace the binds in-place.
"
	| associations′ |
	associations′ := beBinds associations collectAssociations: [ :i :x_sr | i->(f value: i value: x_sr) ].
	beBinds := BindMap newFromAssociations: associations′
]

{ #category : #'SMT interface' }
BindEnv >> smt2: γ [
	self mapBindEnv: [ :i :x_sr |
		| x sr |  x := x_sr key. sr := x_sr value.
		x -> (sr smt2: γ) ]
]

{ #category : #accessing }
BindEnv >> sortDict [
	^(self sortedReftsDict collect: #sr_sort) ", bogusGlits"
	
]

{ #category : #compilation }
BindEnv >> sortedReftsDict [
	^Dictionary newFromAssociations: beBinds values 
	
]

{ #category : #'graph deps' }
BindEnv >> subcKVars: c [
	^(self envKVars: c), c rhsKVars
]

{ #category : #accessing }
BindEnv >> sxEnv [ 
	^Dictionary newFromAssociations: (self bindEnvToList collect: [ :i_x_sr |
				| i x sr |
				i := i_x_sr first.
				x := i_x_sr second.
				sr := i_x_sr third.
				x->(i->sr sr_sort) ])
]

{ #category : #sanitizing }
BindEnv >> symBinds [
"
symBinds  :: F.BindEnv -> [SymBinds]
type SymBinds = (F.Symbol, [(F.Sort, [F.BindId])])
"
	^(self binders groupAssociations collect: [ :each | each groupList ]) associations
]
