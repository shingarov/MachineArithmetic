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
Object >> elabApply: _ [ 
	^self
]

{ #category : #'*Refinements' }
Object >> elabApplyStep: _ [ 
	^self
]

{ #category : #'*Refinements' }
Object >> mapKVars: aBlock [
	^self mapKVars′: [ :kv′_☐ |
		| kv′ |
		kv′ := kv′_☐ first.
		aBlock value: kv′ ]
]

{ #category : #'*Refinements' }
Object >> predReft [
	"View the receiver as a Predicate, and construct a dummy-named Reft.
	 In practice this is used on Expr, but works on any Predicate receiver
	 i.e. any receiver who responds to #prop, cf Refinements.hs:
	
	 predReft      :: (Predicate a) => a -> Reft
	
	Caveat programmator:
	This #predReft is what in SpriteLang is called F.predReft -- not to be
	confused with Sprite's predReft which we Smalltalkers call #ΛpredReft.
	"
	^Reft symbol: String vv_ expr: self prop
]

{ #category : #'*Refinements' }
Object >> printStringInHotel: h [
	^self printString
]

{ #category : #'*Refinements' }
Object >> printUncastOn: aStream [ 
	self printOn: aStream
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

{ #category : #'*Refinements' }
Object >> ≛ [ y
	"Assuming both the receiver and the argument respond to #expr
	 (equivalently in LH parlance, 'have F.Expression typeclass'),
	 construct the Horn Reft stating the receiver is equal to the
	 argument. "
	| atom |
	atom := PAtomEq x: self expr y: y expr.
	^HReft expr: atom
"
peq :: (F.Expression a, F.Expression b) => a -> b -> H.Pred
Cf. Check.hs.
In LH this is part of SpriteLang; however, this author believes
#≛ belongs quite logically in Fixpoint.
"
]
