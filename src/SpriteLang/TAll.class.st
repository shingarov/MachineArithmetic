Class {
	#name : #TAll,
	#superclass : #RType,
	#instVars : [
		'var',
		'type'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
TAll class >> new [
	^self shouldNotImplement
]

{ #category : #'instance creation' }
TAll class >> var: v type: t [
	^self basicNew
		var: v;
		type: t;
		yourself
]

{ #category : #SMT }
TAll >> bkAll [
"bkAll (TAll a s) = (a:as, t) where (as, t) = bkAll s"
	| as_t as t |
	as_t := type bkAll.
	as := as_t key.
	t := as_t value.
	^ {var},as -> t
]

{ #category : #'α-renaming' }
TAll >> collectαRenames: α [
	| var′ α′ |

	var′ := α at:var ifAbsent:[α makeUnique: var].
	α′ := α extMap: var to: var′.

	^α′
]

{ #category : #'as yet unclassified' }
TAll >> freeTVarsGo [
	^self shouldBeImplemented "delete a (go t)"
]

{ #category : #'as yet unclassified' }
TAll >> fresh: Γ [
	^TAll var: var type: (type fresh: Γ)
]

{ #category : #reflect }
TAll >> goReflectTy: f v: v expr: efun xs: xs s₀: s₀ [
	"go xs (ETLam _ e _) (TAll a t)"
	self shouldBeImplemented
]

{ #category : #'as yet unclassified' }
TAll >> goRefresh [
"
go (TAll a t)    = TAll  a (go t)
"
	self shouldBeImplemented 
]

{ #category : #GT }
TAll >> gtChildren [
	^{type}
]

{ #category : #'as yet unclassified' }
TAll >> instantiateGo: ts n: n [
"cf. Elaborate.hs"
	| vt |
	vt := ElabState current freshTVar rVar.
	^(type tsubst: vt tVar: var) instantiateGo: {vt}, ts n: n
]

{ #category : #termination }
TAll >> lim: mO _: m in: γ [
	^TAll
		var: var
		type: (type lim: mO _: m in: γ)
]

{ #category : #printing }
TAll >> printOn: aStream [
	aStream
			nextPutAll: 'TAll ';
			nextPutAll: var;
			nextPutAll: ' ('.
	type printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #prelude }
TAll >> rebind [
	^TAll var: var type: type rebind
]

{ #category : #SMT }
TAll >> sort [
"
rTypeSortAll :: RType -> F.Sort
rTypeSortAll s = genSort (rTypeSort t)
"
	| as_t as t sas n su genSort |
	as_t := self bkAll.  as := as_t key. t := as_t value.
	sas := as. "F.symbol <$> as"
	n := as size.
	su := SortSubst mkSortSubst: (sas zip: ((0 to: n-1) collect: #toFVar)).
	genSort := [ :x |
		| ffunc |
		ffunc := x sortSubst: su.
		(0 to: n-1) inject: ffunc into: [ :soFar :j | soFar @ j ]
		 ].
	^genSort value: t sort
]

{ #category : #'as yet unclassified' }
TAll >> splitTAll [
	"plitTAll :: RType -> ([TVar], RType)"
	| as_t as t |
	as_t := type splitTAll.
	as := as_t first.  t := as_t last.
	^{ {var}, as . t }
]

{ #category : #polymorphism }
TAll >> strengthenTop: _r [
	^self
]

{ #category : #SubsTy }
TAll >> subsTy: su [
	| su′ t′ |
	su′ := su deleteSEnv: var.
	t′ := type subsTy: su.
	^TAll var: var type: t′
]

{ #category : #'F.Subable' }
TAll >> subst: f [
	"subst f (TAll a t)    = TAll a  (F.subst f t)"
	^TAll var: var type: (type subst: f)
]

{ #category : #'F.Subable' }
TAll >> substa: f [
	"substa f (TAll a t)    = TAll a  (F.substa f t)"
	^TAll var: var type: (type substa: f)
]

{ #category : #'F.Subable' }
TAll >> substf: f [
	"substf f (TAll a t)    = TAll a  (F.substf f t)"
	^TAll var: var type: (type substf: f)
]

{ #category : #'F.Subable' }
TAll >> syms [
	"syms (TAll _ t)      = F.syms t"
	^type syms
]

{ #category : #'as yet unclassified' }
TAll >> tsubstGo: t tVar: a [ 
	| b s |
	b := var.
	s := type.
	a = b ifTrue: [ ^TAll var: b type: s "basically myself" ].
	^TAll var: b type: (s tsubstGo: t tVar: a)
]

{ #category : #accessing }
TAll >> type [
	^ type
]

{ #category : #accessing }
TAll >> type: anObject [
	type := anObject
]

{ #category : #'α-renaming' }
TAll >> uniq2: α [
	| α′ var′ type′ |

	var′ := α at:var ifAbsent:[α makeUnique: var].
	α′ := α extMap: var to: var′.
	type′ := type uniq2: α′.

	^self class var: var′ type: type′
]

{ #category : #accessing }
TAll >> var [
	^ var
]

{ #category : #accessing }
TAll >> var: anObject [
	var := anObject
]
