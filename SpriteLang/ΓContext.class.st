Class {
	#name : #'ΓContext',
	#superclass : #Object,
	#instVars : [
		'eBinds',
		'eSize',
		'eTVars'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
ΓContext class >> empEnv: typs [
"
empEnv :: [SrcData] -> Env
"
	| sigs ctorEnv |
	sigs := RType prelude, (typs collectAndCat: #dataSigs).
	ctorEnv := SEnv newFromAssociations: sigs.
	^self basicNew
		eBinds: ctorEnv;
		eSize: 0;
		eTVars: SEnv new
]

{ #category : #'as yet unclassified' }
ΓContext class >> extCase_Ident: y srcBinds: zs ass: ty_t [
"
extCase :: Ident -> [SrcBind] -> (RType, RType) -> Maybe [(F.Symbol, RType)]
"
	| ty t go |
	ty := ty_t key. t := ty_t value.
	go := [ :acc :zzs :tt |
		(zzs notEmpty and: [ tt isKindOf: TFun ]) ifTrue: [
					| Z ZS |
					Z := zzs first. ZS := zzs allButFirst.
					go value: {Z -> tt s}, acc value: ZS value: (tt t subst: tt x with: Z) ]
		ifFalse: [
		zzs isEmpty ifTrue: [ {y -> (ty meet: tt)}, acc ]
		ifFalse: [nil]
		]
	].
	^go value: #() value: (zs collect: #id) value: t
]

{ #category : #'as yet unclassified' }
ΓContext class >> extCase_go: acc _: zzs _: tt [
"
extCase :: Ident -> [SrcBind] -> (RType, RType) -> Maybe [(F.Symbol, RType)]
"
	(zzs notEmpty and: [ tt isKindOf: TFun ]) ifTrue: [ self shouldBeImplemented "go acc (z:zs) (TFun x s t) = go ((z, s) : acc) zs (subst t x z)" ].
	
]

{ #category : #'instance creation' }
ΓContext class >> new [ 
	self shouldNotImplement
]

{ #category : #'as yet unclassified' }
ΓContext >> checkAlt: y rType: t alt: alt [
"
     unfold(G, c, y) === s   G | y + z... * s ~~> G'   G' |- e <== t
     ---------------------------------------------------------------  [Chk-Alt]
     G | y |- C z... -> e <== t

checkAlt :: Env -> Ident -> RType -> SrcAlt -> CG SrcCstr
"
	| c zs e zts |
	c := alt daCon. zs := alt binds. e := alt expr.
	zts := self unfoldEnv: y daCon: c binds: zs.
	zts isNil ifTrue: [ self error: 'checkAlt: incompatible pattern' ].
	^(e check: (self extEnvs: zts) rtype: t) cAlls: zts
]

{ #category : #accessing }
ΓContext >> eBinds [
	^ eBinds
]

{ #category : #accessing }
ΓContext >> eBinds: anObject [
	eBinds := anObject
]

{ #category : #accessing }
ΓContext >> eSize [
	^ eSize
]

{ #category : #accessing }
ΓContext >> eSize: anObject [
	eSize := anObject
]

{ #category : #accessing }
ΓContext >> eTVars [
	^ eTVars
]

{ #category : #accessing }
ΓContext >> eTVars: anObject [
	eTVars := anObject
]

{ #category : #accessing }
ΓContext >> extEnv: x rtype: t [
"
extEnv :: Env -> Symbol -> RType -> Env
"
(x isKindOf: String) ifFalse: [ self error: 'update from L2 to L3!!!' ].
	x = String junkSymbol ifTrue: [ ^self ].
	^self copy
		eBinds: (eBinds at: x nonDestructivePut: t);
		eSize: eSize+1;
		yourself
]

{ #category : #'as yet unclassified' }
ΓContext >> extEnvTV: a [ 
	eTVars at: a put: nil.
	^self
]

{ #category : #'as yet unclassified' }
ΓContext >> extEnvTVs: tvs [
	"NON-destructively add the type vars to the receiver's tVars."
"extEnvTVs :: Env -> [TVar] -> Env"
	| copy |
	copy := self copy.
	tvs do: [ :tv | copy extEnvTV: tv ].
	^copy
]

{ #category : #'as yet unclassified' }
ΓContext >> extEnvs: aCollection [
"
extEnvs :: Env -> [(F.Symbol, RType)] -> Env
extEnvs = L.foldl' (\g (x, t) -> extEnv g x t)
"
	^aCollection inject: self into: [ :γ :x_t |
		| x t |
		x := x_t key. t := x_t value.
		γ extEnv: x rtype: t ]
]

{ #category : #'as yet unclassified' }
ΓContext >> fresh: rtype [
"
Fresh templates for `Unknown` refinements.
fresh :: F.SrcSpan -> Env -> RType -> CG RType
cf. Check.hs
"
"TODO: do not go through this; send the below directly:"
	^rtype fresh: self
]

{ #category : #'as yet unclassified' }
ΓContext >> freshK: t [
"
freshK :: F.SrcSpan -> Env -> F.Sort -> CG Reft
"
	| xs_ts xs ts v k |
	xs_ts := self sorts unzipAssociations. xs := xs_ts first. ts := xs_ts last.
	v := CGState current freshValueSym.
	k := ({t}, ts) freshKVar.

	^KnownReft symbol: v expr: (RefVarApp var: k args: {v}, xs)
]

{ #category : #accessing }
ΓContext >> getEnv: sym [
"
getEnv :: Env -> F.Symbol -> Maybe RType
"
	^eBinds at: sym ifAbsent: [nil]
]

{ #category : #accessing }
ΓContext >> getEnvDamit: sym [
	^eBinds at: sym
]

{ #category : #'as yet unclassified' }
ΓContext >> grdSym [
"
grdSym :: Env -> F.Symbol
grdSym env = F.tempSymbol 'grd' (eSize env)
"
	^'grd' tempSymbol: self eSize
]

{ #category : #polymorphism }
ΓContext >> immS: i [
"immS :: Env -> SrcImm -> ElabM ([RType], Int, RType)"
	^(i immTy: self) instantiate
]

{ #category : #polymorphism }
ΓContext >> initialize: n [
	super initialize: n.
	self initializeTVars
]

{ #category : #polymorphism }
ΓContext >> initializeTVars [
	eTVars := Dictionary new "(F.SEnv ())"
]

{ #category : #'as yet unclassified' }
ΓContext >> refresh: rtype [ 
	^self fresh: rtype goRefresh
]

{ #category : #'as yet unclassified' }
ΓContext >> sorts [
	"envSorts :: Env -> [(F.Symbol, F.Sort)]
	cf. Constraints.hs"
	^(eBinds 	associations collectAssociations: [ :x :s |
		| t__ t |
		t__ := s sortPred: x.
		t__ isNil ifFalse: [ x -> t__ first ] ifTrue: [ nil ]
	]) reject: #isNil
]

{ #category : #'case switching' }
ΓContext >> unfoldDaCon: c ident: y [
	| sig as_ps_t as ps t  ty ts rs prs ats |
	sig := self getEnv: c.
	as_ps_t := sig bkAlls. "why <$>?"
		as := as_ps_t first. ps := as_ps_t second. t := as_ps_t third.
	ty  := self getEnv: y.
	ts  := ty ts. rs := ty ars.
	prs := ps zip: rs.
	ats := as zip: ts.
	
	^ty -> ((t tsubsts: ats) rsubsts: prs)
]

{ #category : #'case switching' }
ΓContext >> unfoldEnv: y daCon: c binds: zs [
"
unfoldEnv :: Env -> Ident -> DaCon -> [SrcBind] -> Maybe [(F.Symbol, RType)]
NB: In Smalltalk these [(F.Symbol, RType)] are Associations.
"
	^ΓContext
		extCase_Ident: y
		srcBinds: zs
		ass: (self unfoldDaCon: c ident: y)
]

{ #category : #'case switching' }
ΓContext >> unfoldEnv′: y daCon: c binds: zs [
"
unfoldEnv' :: Env -> Ident -> DaCon -> [SrcBind] -> Maybe Env
"
	| unfolded |
	unfolded := self unfoldEnv: y daCon: c binds: zs.
	unfolded isNil ifTrue: [ ^nil ].
	^self extEnvs: unfolded
]
