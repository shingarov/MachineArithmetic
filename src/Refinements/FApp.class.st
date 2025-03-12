"
I am a brain-damaged function-application Sort which is not a Z3Sort.
Cf. Sorts.hs:
data Sort =
  ...
  | FApp  !Sort !Sort    -- ^ constructed type
"
Class {
	#name : #FApp,
	#superclass : #PreSort,
	#instVars : [
		's',
		't'
	],
	#category : #'Refinements-Sorts'
}

{ #category : #'instance creation' }
FApp class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
FApp class >> predDomainTaking: nFVars [
	"Convenience higher-level wrapper around #s:t: for building predicates."
	| D from to |
	D := (0 to: nFVars-1) collect: #toFVar.
	^D
		inject: (FTC new: (TC symbol: 'Pred'))
		into: [ :soFar :each | FApp s: soFar t: each ].
]

{ #category : #'instance creation' }
FApp class >> s: aSort t: anotherSort [
	^self basicNew
		s: aSort;
		t: anotherSort;
		yourself
]

{ #category : #comparing }
FApp >> = rhs [
	self class = rhs class ifFalse: [ ^false ].
	^s = rhs s and: [ t = rhs t ]
]

{ #category : #visiting }
FApp >> accept: aVisitor [ 
	^FApp
		s: (s accept: aVisitor)
		t: (t accept: aVisitor)
]

{ #category : #visiting }
FApp >> apply: θ [ 
	^FApp
		s: (s apply: θ)
		t: (t apply: θ)
]

{ #category : #'as yet unclassified' }
FApp >> checkNumeric: env tvSubst: θ [ 
	^nil
]

{ #category : #testing }
FApp >> containsFVar [
	^s containsFVar or: [ t containsFVar ]
]

{ #category : #visiting }
FApp >> goMapSort: stepBlock [
"cf. Visitor.hs"
	^FApp s: (stepBlock value: s) t: (stepBlock value: t)
]

{ #category : #comparing }
FApp >> hash [
	^s hash
]

{ #category : #testing }
FApp >> isBitVectorSort [
	(s isKindOf: FTC) ifFalse: [ ^false ].
	(s typeConstructor isKindOf: FTyconBitVec) ifFalse: [ ^false ].
	self assert: t typeConstructor isBitVecSizeTC.
	^true
]

{ #category : #'bit-vectors' }
FApp >> length [
	self assert: self isBitVectorSort.
	^t typeConstructor length
]

{ #category : #hotel }
FApp >> monomorphicDeclIn: γ [
	self assert: (s isKindOf: FTC).
	^s typeConstructor applyTo: self unFApp allButFirst in: γ
]

{ #category : #printing }
FApp >> printOn: aStream [
	aStream nextPutAll: '(FApp '.
	s printOn: aStream.
	aStream space.
	t printOn: aStream.
	aStream nextPutAll: ')'.
]

{ #category : #accessing }
FApp >> s [
	^ s
]

{ #category : #accessing }
FApp >> s: anObject [
	s := anObject
]

{ #category : #'bit-vectors' }
FApp >> sizeSort [
	self assert: self isBitVectorSort.
	^t
]

{ #category : #'sort algebra' }
FApp >> sortAbs [
"
sortAbs (FApp  s1 s2) = max (sortAbs s1) (sortAbs s2)
"
	^s sortAbs max: t sortAbs
]

{ #category : #substitution }
FApp >> sortSubst: θ [
"
sortSubst θ (FApp t1 t2)  = FApp  (sortSubst θ t1) (sortSubst θ t2)
"
	^θ at: self ifAbsent: [
		FApp
			s: (s sortSubst: θ)
			t: (t sortSubst: θ)
		]
]

{ #category : #substitution }
FApp >> subst: j _: tj [ 
	| s′ t′ |
	s′ := s subst: j _: tj.
	t′ := t subst: j _: tj.
	^FApp s: s′ t: t′
]

{ #category : #accessing }
FApp >> t [
	^ t
]

{ #category : #accessing }
FApp >> t: anObject [
	t := anObject
]

{ #category : #private }
FApp >> unFAppGo: acc [
"
unFApp = go []
  where
    go acc (FApp t1 t2) = go (t2 : acc) t1  ← we are here
    go acc t            = t : acc
Cf. Sorts.hs
"
	^s unFAppGo: ({t}, acc)
]

{ #category : #hotel }
FApp >> z3sort: γ [
	| ct_ts ct ts |
	ct_ts := self unFApp.  ct := ct_ts first.  ts := ct_ts allButFirst.
	^ct fappSmtSort: ts originalFApp: self in: γ
]
