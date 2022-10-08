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
	sigs := RType prelude, typs collectAndCat: #dataSigs.
	ctorEnv := SEnv newFromAssociations: sigs.
	^self basicNew
		eBinds: ctorEnv;
		eSize: 0;
		eTVars: SEnv new
]

{ #category : #'instance creation' }
ΓContext class >> new [ 
	self shouldNotImplement
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
	k := t freshKVar: ts.

	^KnownReft symbol: v expr: (RefVarApp var: k args: {v}, xs)
]

{ #category : #accessing }
ΓContext >> getEnv: sym [
self shouldBeImplemented .
	^self at: sym
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
"immS :: Env -> SrcImm -> ElabM ([RType], RType)"
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
