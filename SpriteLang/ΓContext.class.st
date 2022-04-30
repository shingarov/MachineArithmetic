Class {
	#name : #'ΓContext',
	#superclass : #Dictionary,
	#instVars : [
		'tVars'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
ΓContext class >> empEnv [
"
empEnv :: Env
empEnv = F.emptySEnv
"
	^super new
]

{ #category : #'instance creation' }
ΓContext class >> new [ 
	self shouldNotImplement
]

{ #category : #accessing }
ΓContext >> extEnv: x rtype: t [
"
extEnv :: Env -> Symbol -> RType -> Env
"
(x isKindOf: String) ifFalse: [ self error: 'update from L2 to L3!!!' ].
	x = String junkSymbol ifTrue: [ ^self ].
	^self copy
		at: x put: t;
		yourself
]

{ #category : #'as yet unclassified' }
ΓContext >> extEnvTV: a [ 
	tVars at: a put: nil.
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
ΓContext >> freshK: aΛBase [
"
freshK :: F.SrcSpan -> Env -> Base -> CG Reft
"
	| t xs_ts xs ts v k |
	t := aΛBase baseSort.
	xs_ts := self sorts unzipAssociations. xs := xs_ts first. ts := xs_ts last.
	v := CGState current freshValueSym.
	k := t freshKVar: ts.
	^KnownReft symbol: v expr: (RefVarApp var: k args: {v}, xs)
]

{ #category : #accessing }
ΓContext >> getEnv: sym [
	^self at: sym
]

{ #category : #'as yet unclassified' }
ΓContext >> grdSym [
	^'grd' tempSymbol: self size
]

{ #category : #polymorphism }
ΓContext >> immS: i [
"mmS :: Env -> SrcImm -> ElabM ([RType], RType)"
	^(i immTy: self) instantiate
]

{ #category : #polymorphism }
ΓContext >> initialize: n [
	super initialize: n.
	self initializeTVars
]

{ #category : #polymorphism }
ΓContext >> initializeTVars [
	tVars := Dictionary new "(F.SEnv ())"
]

{ #category : #'as yet unclassified' }
ΓContext >> refresh: rtype [ 
	^self fresh: rtype goRefresh
]

{ #category : #'as yet unclassified' }
ΓContext >> sorts [
	"envSorts :: Env -> [(F.Symbol, F.Sort)]
	cf. Constraints.hs"
	^(self 	associations collect: [ :x_s |
		| x s t__ t |
		x := x_s key.
		s := x_s value.
		t__ := s sortPred: x.
		t__ isNil ifFalse: [ x -> t__ first ] ifTrue: [ nil ]
	]) reject: #isNil
]
