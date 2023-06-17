"
Sprite's own concept of refined type.
It can either be of the form
  Int{r}
(because we only know about one base type, Z),
or of the form
  x:s -> t
where x is an identifier and s and t are SpriteRTypes.
"
Class {
	#name : #RType,
	#superclass : #Object,
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
RType class >> prelude [
"
prelude :: [(F.Symbol, RType)]
prelude =
  [ ('diverge'   , mkTy 'x:int => 'a')
  , ('impossible', mkTy 'x:int[v|false] => 'a')
  ]
"
	^{
	'diverge'     -> (RTypeParser mkTy: 'x:int => ''a').
	'impossible'  -> (RTypeParser mkTy: 'x:int[v|Bool false] => ''a').
	}
]

{ #category : #'as yet unclassified' }
RType class >> unifys: collection1 with: collection2 [
"
unifys :: F.SrcSpan -> [RType] -> [RType] -> ElabM [RType]
"
	collection1 size = collection2 size ifFalse: [ self error ].
	collection1 isEmpty ifTrue: [ ^#() ].
	
	^self unifysNonEmpty: collection1 with: collection2
]

{ #category : #'as yet unclassified' }
RType class >> unifysNonEmpty: coll1 with: coll2 [
	| t1 t1s t2 t2s t ts t1s′ t2s′ |
	t1 := coll1 first.  t1s := coll1 allButFirst.
	t2 := coll2 first.  t2s := coll2 allButFirst.
	t := t1 unify: t2.
	t1s′ := t1s collect: [ :eachChildT | eachChildT subsTyM ].
	t2s′ := t2s collect: [ :eachChildT | eachChildT subsTyM ].
	ts := self unifys: t1s′ with: t2s′.
	^{t}, ts


]

{ #category : #polymorphism }
RType >> assign: tVar [
	ElabState current updSub: tVar rtype: self
]

{ #category : #SMT }
RType >> bkAll [
"bkAll :: RType -> ([TVar], RType)
bkAll t          = ([]  , t)"
	^ #() -> self
]

{ #category : #SMT }
RType >> bkAlls [
"
bkAlls :: RType -> ([TVar], [RVar], RType)
bkAlls s     = (as, ps, t)
  where
    (as, s') = bkAll s
    (ps, t)  = bkRAll s'
"
	| as ps t as_s1 ps_t s1 |
	as_s1 := self bkAll.  as := as_s1 key.  s1 := as_s1 value.
	ps_t := s1 bkRAll.  ps := ps_t key.  t := ps_t value.
	^ { as . ps . t }
]

{ #category : #'refinement abstraction' }
RType >> bkFun [
"
bkFun :: RType -> ([(F.Symbol, RType)], RType)
bkFun out          = ([]          , out) -- for everyone except TFun
"
	^#() -> self
]

{ #category : #SMT }
RType >> bkRAll [
"bkRAll :: RType -> ([RVar], RType)
bkRAll t          = ([]  , t)"
	^ #() -> self
]

{ #category : #'as yet unclassified' }
RType >> cAll: symbol cstr: cc [
"
cAll :: F.SrcSpan -> F.Symbol -> RType -> SrcCstr -> SrcCstr
cAll _ x t c = case sortPred x t of
  Just (so, p) -> H.All (H.Bind x so p) c
  _            -> c
"
	| so_p so p |
	so_p := self sortPred: symbol.
	so_p isNil ifTrue: [ ^cc ].
	so := so_p first.
	p := so_p last.
	^CstrAll bind: (HBind x: symbol τ: so p: p) p: cc
]

{ #category : #'as yet unclassified' }
RType >> cAllF: symbol cstr: cc [
"
-- | @cAllF@ is a variant of @cAll@ used when the binder is a function, e.g. in [Chk-RAbs]
cAllF :: F.SrcSpan -> F.Symbol -> RType -> SrcCstr -> SrcCstr
cAllF _ f t c = H.All (H.Bind f (rTypeSort t) mempty) c
"
	^CstrAll bind: (HBind x: symbol τ: self sort p: (HPredAnd of: #())) p: cc
]

{ #category : #'as yet unclassified' }
RType >> closeType: rvs xts: xts [
"
closeType :: [RVar] -> [(F.Symbol, RType)] -> RType -> RType
              rvs       xts                   self
"
	| valParams rvParams |
	valParams := xts reversed inject: self into: [ :s :xt |
		| x t |
		x := xt key. t := xt value.
		TFun x: x s: t t: s ].
	rvParams := rvs reversed inject: valParams into: [ :rtypeSoFar :eachRVar | TRAll r: eachRVar t: rtypeSoFar ].
	^rvParams generalize
]

{ #category : #polymorphism }
RType >> dispatchUnify: t1 [
	"The 'normal' case where we just fall through to unifyLL:."
	^t1 unifyLL: self
]

{ #category : #'as yet unclassified' }
RType >> freeTVars [
	^self freeTVarsGo asSortedCollection
]

{ #category : #'as yet unclassified' }
RType >> fresh: Γ [
"
fresh :: F.SrcSpan -> Env -> RType -> CG RType
"
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
RType >> generalize [
	"Normalize types by generalizing tyvars, refactoring ref-var applications."
"
generalize :: RType -> RType
"
	^self generalizeTVar refactorApp
]

{ #category : #'as yet unclassified' }
RType >> generalizeTVar [
"
generalizeTVar :: RType -> RType
"
	^self freeTVars reversed inject: self into: [ :typeSoFar :thisVar | TAll var: thisVar type: typeSoFar ]
]

{ #category : #'as yet unclassified' }
RType >> goRefresh [
"
-- | Fresh templates for `Unknown` refinements
refresh :: F.SrcSpan -> Env -> RType -> CG RType

cf. Check.hs
"
	self subclassResponsibility 
]

{ #category : #GT }
RType >> gtChildren [
	^#()
]

{ #category : #GT }
RType >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 50>
	^ composite fastTree
		title: 'Tree';
		children: #gtChildren;
		display: [ Array with: self ]
]

{ #category : #polymorphism }
RType >> instantiate [
"instantiate :: RType -> ElabM ([RType], Int, RType)"
	^self instantiateGo: #() n: 0
]

{ #category : #polymorphism }
RType >> instantiateGo: ts_ n: n [
"cf. Elaborate.hs"
	^{ ts_ reversed . n . self }
]

{ #category : #testing }
RType >> isBool [
"
isBool :: RType -> Bool
isBool t = rTypeSort t == F.boolSort

cf. Parse.hs
"
	^self sort == Bool sort
]

{ #category : #'as yet unclassified' }
RType >> isRSort [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
RType >> meet: t2 [
"
meet :: RType -> RType -> RType
"
	| r2 |
	r2 := t2 reft.
	r2 isNil ifTrue: [ ^self ].
	^self strengthenTop: r2
]

{ #category : #'refinement abstraction' }
RType >> mkRVar: p [
"
mkRVar :: F.Symbol -> RType -> RVar
mkRVar p t
  | isBool out = RVar p [ const () <$> s | (_, s) <- xs ]
  | otherwise  = error 'Refinement variable must have `bool` as output type'
  where
    (xs, out)  = bkFun t
"
	| xs_out xs out |
	xs_out := self bkFun. xs := xs_out key. out := xs_out value.
	out isBool ifFalse: [ self error: 'Refinement variable must have `bool` as output type' ].
	^RVar
		rvName: p
		rvArgs: (xs collect: [ :__s | 
			| eachS |
			eachS := __s value.
			eachS collect: [ :r | nil ]
			])
]

{ #category : #'as yet unclassified' }
RType >> rSortToFSort [
"
rSortToFSort :: RSort -> F.Sort
rSortToFSort = rTypeSort . rSortToRType
cf Types.hs

RSorts are just Types decorated with unit refinements:

type RSort = Type ()

where the hierarchy of TBase, TCon, ... are cases of Type,
parametrized over 'a which can be Reft (for RType and RARef),
or ()/nil (for RSort).
In Smalltalk this is purely dynamic.
"
	^self rSortToRType sort
]

{ #category : #'as yet unclassified' }
RType >> rSortToRType [
	"Replace the nil refinement with the empty refinement.
	 In Smalltalk, we can't use the `fmap (K ε)` trick.  (Can we?)"
	self subclassResponsibility
]

{ #category : #private }
RType >> rTypeSortFun_go: ts [
"
  rTypeSortFun :: RType -> F.Sort
  rTypeSortFun = F.mkFFunc 0 . fmap rTypeSort . go []
    where
      go ts (TFun _ t1 t2) = go (t1:ts) t2
      go ts t              = reverse (t:ts)   ← we are here
"
	^({self}, ts) reversed
]

{ #category : #prelude }
RType >> rebind [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
RType >> refactorApp [
"
refactorApp :: RType -> RType
{- | [NOTE:RefactorApp] The parser cannot distinguish between 
       * plain   applications (f x y z) and 
       * ref-var applications (p x y z) using 
         `H.Var  !F.Symbol ![F.Symbol] -- ^ $k(y1..yn)`
      So, post-parsing, we traverse the refinements with an `isRV` 
      test to pull the ref-var applications out.
 -}
This Haskell design can not be transliterated into Smalltalk,
because of DecidableRefinements.
"
	| as_ps_t as ps _t γ refactored |
	as_ps_t := self bkAlls.  as := as_ps_t first.  ps := as_ps_t second.  _t := as_ps_t third.
	γ := EvalEnv constants: (Dictionary newFromAssociations:
		( (ps collect: #rvName) asSet collect: [ :r | r -> (DummyRVar named: r) ] ) asArray,
		(  as                         collect: [ :a | a -> (DummyTVar named: a) ] ) asArray ).
	refactored := _t refactorAppR: γ.
	^(refactored tRAll: ps) tAll: as
]

{ #category : #accessing }
RType >> reft [
"
rTypeReft :: RType -> Maybe Reft
"
	^nil
]

{ #category : #'as yet unclassified' }
RType >> rinst [
	^self
]

{ #category : #SubsARef }
RType >> rsubsts: rps [
"
rsubsts :: (SubsARef a) => [(RVar, RARef)] -> a -> a
rsubsts rps z = L.foldl' (\x (p, ar) -> rsubst1 p ar x) z rps
" 
	^rps inject: self into: [ :thisTime :p_ar |
		| p ar |
		p := p_ar key. ar := p_ar value.
		thisTime rsubst1: p with: ar ]
]

{ #category : #'as yet unclassified' }
RType >> rtypeSort [
"
rTypeSort :: RType -> F.Sort
"
	self subclassResponsibility
]

{ #category : #polymorphism }
RType >> singTvSub: a [ 
	^TvSub newFromAssociations: {a symbol -> self}
]

{ #category : #'synthesis constraints' }
RType >> singleton: x [
	^self
]

{ #category : #SMT }
RType >> sort [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
RType >> sortPred: aString [
"
sortPred :: F.Symbol -> RType -> Maybe (F.Sort, H.Pred)
"
	^nil "sortPred _ _ = Nothing"
]

{ #category : #'as yet unclassified' }
RType >> splitTAll [
	^{ #() . self }
]

{ #category : #polymorphism }
RType >> strengthenTop: r [
"strengthenTop :: RType -> Reft -> RType"
	^self subclassResponsibility
]

{ #category : #SubsARef }
RType >> subs: p ar: ar [ 
	^self collect: [ :each | each subs: p ar: ar ]
]

{ #category : #SubARef }
RType >> subsAR: p ar: ar [
	"If in Smalltalk we could 'derive Functor', this would be expressed generically:
	   instance SubsARef RType where
	     subsAR p ar t = subsAR p ar <$> t
	 the visiting taken care automatically by #<$>.
	 For now, let's write the visitor manually but it should be easy to at least
	 reexpress this via #⊛ because RType, ARef etc are already functors -- see #62.
	"
	self subclassResponsibility
]

{ #category : #'F.Subable' }
RType >> subst: f [
	"instance F.Subable r => F.Subable (Type r) where
	   -- subst  :: Subst -> a -> a "
	self subclassResponsibility
]

{ #category : #'F.Subable' }
RType >> substa: f [
	"instance F.Subable r => F.Subable (Type r) where
	   -- substa :: (Symbol -> Symbol) -> Type r -> Type r "
	self subclassResponsibility
]

{ #category : #'F.Subable' }
RType >> substf: f [
	"instance F.Subable r => F.Subable (Type r) where
	   -- substf :: (Symbol -> Expr) -> Type r -> Type r "
	self subclassResponsibility
]

{ #category : #'F.Subable' }
RType >> syms [
	"instance F.Subable r => F.Subable (Type r) where
	   -- syms   :: a -> [Symbol] "
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
RType >> tAll: as [
	^as reversed inject: self into: [ :soFar :thisTVar | TAll var: thisTVar type: soFar ]
]

{ #category : #'as yet unclassified' }
RType >> tRAll: ps [
	^ps  reversed inject: self into: [ :soFar :thisRVar | TRAll r: thisRVar t: soFar ]
]

{ #category : #polymorphism }
RType >> tsubst: ty tVar: a [
"
tsubst :: TVar -> RType -> RType -> RType
"
	^self tsubstGo: ty tVar: a "In Smalltalk this indirection through go is probably not needed"
]

{ #category : #polymorphism }
RType >> tsubstGo: ty tVar: a [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
RType >> tsubsts: ats [
"
substs :: [(TVar, RType)] -> RType -> RType
" 
	^ats inject: self into: [ :ss :a_t | ss tsubst: a_t value tVar: a_t key ]
]

{ #category : #polymorphism }
RType >> unify: t2 [
"
unify :: F.SrcSpan -> RType -> RType -> ElabM RType

	This double-dispatch through the type of t2 is unique to Smalltalk.
	It is needed for the case
		unify l t (TBase (TVar a) _) = ...
	(cf. Elaborate.hs)
"
	^t2 dispatchUnify: self
]

{ #category : #'as yet unclassified' }
RType >> ≺ [ t
	self subclassResponsibility 
]
