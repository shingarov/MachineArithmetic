Class {
	#name : #'ΓContext',
	#superclass : #Dictionary,
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
