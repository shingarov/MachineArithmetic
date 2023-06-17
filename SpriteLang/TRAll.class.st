Class {
	#name : #TRAll,
	#superclass : #RType,
	#instVars : [
		'r',
		't'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
TRAll class >> r: r t: t [
	^self basicNew
		r: r;
		t: t;
		yourself
]

{ #category : #SMT }
TRAll >> bkRAll [
"
bkRAll (TRAll r t) = (r:ps, u) where (ps, u) = bkRAll t
"
	| ps_u ps u |
	ps_u := t bkRAll.  ps := ps_u key.  u := ps_u value.
	^{r},ps -> u
]

{ #category : #'as yet unclassified' }
TRAll >> freeTVarsGo [
	^r freeTVarsGoP union: t freeTVarsGo
]

{ #category : #'as yet unclassified' }
TRAll >> fresh: Γ [
	^TRAll
		r: r
		t: (t fresh: Γ)
]

{ #category : #GT }
TRAll >> gtChildren [
	^{t}
]

{ #category : #polymorphism }
TRAll >> instantiateGo: ts n: n [
"cf. Elaborate.hs"
	^t instantiateGo: ts n: n+1
]

{ #category : #printing }
TRAll >> printOn: aStream [
	aStream nextPutAll: 'TRAll('.
	r printOn: aStream.
	aStream nextPutAll: ' ('.
	t printOn: aStream.
	aStream nextPutAll: '))'
	
		
]

{ #category : #accessing }
TRAll >> r [
	^ r
]

{ #category : #accessing }
TRAll >> r: anObject [
	r := anObject
]

{ #category : #'as yet unclassified' }
TRAll >> rinst [
"
rinst :: F.SrcSpan -> RType -> CG RType
rinst l (TRAll (RVar p ts) s) = do
  ar <- freshKVarReft l ts
  return (subsAR p ar s)
cf. Check.hs
"
	| p ts s ar |
	p  := r rvName.
	ts := r rvArgs.
	s := t.
	(r isKindOf: RVar) ifFalse: [ self shouldBeImplemented "fall through to super!" ].
	ar := ts freshKVarReft.
	^t subsAR: p ar: ar
]

{ #category : #SMT }
TRAll >> sort [
	^t sort
]

{ #category : #polymorphism }
TRAll >> strengthenTop: xxx [
	self shouldBeImplemented
]

{ #category : #SubsTy }
TRAll >> subsTy: su [
	| r′ t′ |
	r′ := r subsTy: su.
	t′ := t subsTy: su.
	^TRAll r: r′ t: t′
]

{ #category : #accessing }
TRAll >> t [
	^ t
]

{ #category : #accessing }
TRAll >> t: anObject [
	t := anObject
]

{ #category : #polymorphism }
TRAll >> tsubstGo: t′ tVar: a [
"
go (TRAll p t)      = TRAll  (goP p) (go t)
"
	^TRAll
		r: (r tsubstGoP: t′ tVar: a)
		t: (t tsubstGo: t′ tVar: a)
]
