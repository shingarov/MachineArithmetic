Extension { #name : #Object }

{ #category : #'*Refinements' }
Object >> dCut [
	^Elims
		cuts: (Set with: self)
		nonCuts: Set new
]

{ #category : #'*Refinements' }
Object >> dNonCut [
	^Elims
		cuts: Set new
		nonCuts: (Set with: self)
]

{ #category : #'*Refinements' }
Object >> isJunkFxEVar [
	^false
]

{ #category : #'*Refinements' }
Object >> mapKVars: aBlock [
	^self mapKVars1: [ :kv1__ |
		| kv1 |
		kv1 := kv1__ first.
		aBlock value: kv1 ]
]

{ #category : #'*Refinements' }
Object >> predReft [
	"View the receiver as a Predicate, and construct a dummy-named Reft.
	 In practice this is used on Expr, but works on any Predicate receiver
	 i.e. any receiver who responds to #prop, cf Refinements.hs:
	
	predReft      :: (Predicate a) => a -> Reft
	"
	^Reft symbol: String vv_ expr: self prop
]

{ #category : #'*Refinements' }
Object >> printStringInHotel: h [
	^self printString
]

{ #category : #'*Refinements' }
Object >> propReft [
"
propReft      ::  (Predicate a) => a -> Reft
cf. Refinements.hs
"
	^Reft symbol: String vv_ expr: self shouldBeImplemented
]

{ #category : #'*Refinements' }
Object >> subst: θ [
	self error: 'Dont know how to substitute in ', self class name
]

{ #category : #'*Refinements' }
Object >> subst: θ exceptAll: xes [
"
substExcept  :: Subst -> [Symbol] -> Subst
-- substExcept  (Su m) xs = Su (foldr M.delete m xs)
substExcept (Su xes) xs = Su $ M.filterWithKey (const . not . (`elem` xs)) xes
"
	^self subst: (θ exceptAll: xes)
]
