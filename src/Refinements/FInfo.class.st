Class {
	#name : #FInfo,
	#superclass : #HornInfo,
	#category : #Refinements
}

{ #category : #'instance creation' }
FInfo class >> defsFInfo: defs [
"
defsFInfo :: [Def a] -> FInfo a
Cf. Parse.hs
"
	^self basicNew initializeFromDefs: defs
]

{ #category : #logic }
FInfo >> convertFormat [
	"Convert FInfo query to SInfo.
	cf. Types/Constraints.hs:convertFormat"
	| bindm_fi′ bindm fi′ |
	bindm_fi′ := cm
		injectWithKey: (BindM new -> self)
		into: [ :m_fi :i :c | c outVV: m_fi i: i ].
	bindm := bindm_fi′ key.  fi′ := bindm_fi′ value.
	fi′ cm: (fi′ cm collect: [ :subc | subc toSimpC: bindm_fi′ key ]).
	^fi′ as: SInfo
]

{ #category : #'private - initialization' }
FInfo >> initializeFromDefs: defs [
"
Cf. Parse.hs
This is inefficient as it walks over defs multiple times,
but at least textually consistent with LF.
"
	self initializeMempty.
	cm := Dictionary newFromAssociations: (defs select: [ :def | def isKindOf: SubC ] thenCollect: [ :subc | subc id -> subc ]).
	bs := BindEnv empty.
	ebinds := #().
	ws := KVEnv new.
	quals := OrderedCollection new.
	gLits := SEnv new.
	kuts := Kuts new.
	ddecls := OrderedCollection new.
	ae := AxiomEnv new.
	options := QueryOptions new.
]

{ #category : #logic }
FInfo >> reduce [
	| simplifiedFi reducedFi |
	simplifiedFi := self simplifyBindings.
	reducedFi := simplifiedFi reduceEnvironments.
	^reducedFi
]

{ #category : #'environment reduction' }
FInfo >> reduceEnvironments [
	"TODO - implement me!"
	^self
]

{ #category : #logic }
FInfo >> remakeQual [
	"Destructively remake quals."
	quals := quals collect: [ :qual | qual remake ].
	^self
]

{ #category : #logic }
FInfo >> simplify [
"
simplifyFInfo :: (NFData a, Fixpoint a, Show a, Loc a)
               => Config -> FInfo a -> IO (SInfo a)
"
	| reducedFi fi1 si0 si1 si2 si3 si4 si5 si6 |
	reducedFi := self reduce.
	fi1 := reducedFi remakeQual.
	si0 := fi1 convertFormat.
	si1 := si0 sanitize.
	si1 compile. "away all DecidableRefinements"
	si2 := si1 wfcUniqify.
	si3 := si2 "renameAll".
	si4 := si3 "defunctionalize".
	si5 := si4 elaborate.
	si6 := si5 "expand, if extensionality".
	"if rewrite axioms, instantiate then ^#Nothing"
	^si6
]

{ #category : #'environment reduction' }
FInfo >> simplifyBindings [
	"Cf. Solver/EnvironmentReduction.
	 Simplify bindings in constraint environments.
	 It runs 'mergeDuplicatedBindings' and 'simplifyBooleanRefts'
	 on the environment of each constraint.
	 If 'inlineANFBindings cfg' is on, also runs 'undoANF' to inline
	 @lq_anf@ bindings.
	
	simplifyBindings :: Config -> FInfo a -> FInfo a
	"
	^self "TODO.  This will be implemented one day; for now we are equivalent to running with --no-environment-reduction" 
]

{ #category : #solving }
FInfo >> solve [
	^[ self solve1 ] runHotel
	
]

{ #category : #solving }
FInfo >> solve1 [
	^self slice solveNative
	
]

{ #category : #solving }
FInfo >> solveNative [
"
solveNative, solveNative' :: (NFData a, Fixpoint a, Show a, Loc a) => Solver a
"
	^self solveNative′
	
]

{ #category : #solving }
FInfo >> solveNative′ [
	| si6 res |
	si6 := self simplify.
	res := si6 solve.
	^res
	
]
