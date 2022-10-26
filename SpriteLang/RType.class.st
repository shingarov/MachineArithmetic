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
	^#() "TODO"
]

{ #category : #'as yet unclassified' }
RType class >> rVar: symbol [
"rVar :: F.Symbol -> RType"
	^TBase b: (TVar symbol: symbol) r: ΛReft new
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
RType class >> unifysNonEmpty: collection1  with: collection2 [
	| head1 tail1 tail1_ head2 tail2 tail2_ head tail |
	head1 := collection1 first.  tail1 := collection1 allButFirst.
	head2 := collection2 first.  tail2 := collection2 allButFirst.
	
	head := head1 unify: head2.
	
	tail1 isEmpty ifFalse: [
		self shouldBeImplemented
	"  t1s' <- mapM subsTyM t1s
    t2s' <- mapM subsTyM t2s
    ts   <- unifys l t1s' t2s'
    return (t:ts)"
		  ].
	^{head} "BOGUS, implement the above tail"
	


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
	^self freeTVars reversed inject: self into: [ :typeSoFar :thisVar | TAll var: thisVar type: typeSoFar ]
]

{ #category : #GT }
RType >> gtChildren [
	^#()
]

{ #category : #'as yet unclassified' }
RType >> instantiate [
"instantiate :: RType -> ElabM ([RType], RType)"
	^self instantiateGo: #()
]

{ #category : #'as yet unclassified' }
RType >> instantiateGo: ts_ [
"cf. Elaborate.hs"
	^{ ts_ . self }
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
RType >> ≺ [ t
	self subclassResponsibility 
]
