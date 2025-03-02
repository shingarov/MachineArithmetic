"
newtype Subst = Su (M.HashMap Symbol Expr)
Cf. Types/Refinements.hs

class Subable a where
  syms   :: a -> [Symbol]                   -- ^ free symbols of a
  substa :: (Symbol -> Symbol) -> a -> a
  -- substa f  = substf (EVar . f)

  substf :: (Symbol -> Expr) -> a -> a
  subst  :: Subst -> a -> a
  subst1 :: a -> (Symbol, Expr) -> a
  subst1 y (x, e) = subst (Su $ M.fromList [(x,e)]) y

"
Class {
	#name : #Subst,
	#superclass : #Dictionary,
	#category : #'PreSmalltalks-Substitutions'
}

{ #category : #'instance creation' }
Subst class >> Su: m [
	^self newFromAssociations: m
]

{ #category : #'instance creation' }
Subst class >> mkSubst: associations [
	"Make a Subst from the argument which is a sequence of Associations of the form, varName->EVar.
	cf. Types/Substitutions.hs (not the other one)"
	| nonTrivial |
	nonTrivial := associations reject: [ :ass | ass value isConstantNamed: ass key ].
	^self Su: nonTrivial reversed
]

{ #category : #collection }
Subst >> catSubst: θ2 [
"
catSubst :: Subst -> Subst -> Subst
Cf. Types/Substitutions.hs
"
	| s1 s2 self_ |
	s1 := self associations.
	s2 := θ2 associations.
	self_ := self collect: [ :v | v subst: θ2 ].
	^θ2 union: self_ "opposite order from LF, because in Smalltalk the rhs map wins and in Haskell the lhs map wins"
]

{ #category : #compilation }
Subst >> evaluateIn: anEvalEnv ifUndeclared: vndBlock [
	| newList |
	newList := self associations collect: [ :v_expr |
		| v expr |
		v := v_expr key.
		expr := v_expr value.
		v -> (expr evaluateIn: anEvalEnv ifUndeclared: vndBlock) ].
	^self class newFromAssociations: newList
]

{ #category : #collection }
Subst >> except: theseKeys [
	^self withoutKeys: theseKeys "TODO: only needed for consistency with LqFx, some day we'll remove this"
]

{ #category : #'as yet unclassified' }
Subst >> exceptAll: xes [ 
	^self withoutKeys: xes
]

{ #category : #printing }
Subst >> printOn: aStream [
	self isEmpty ifTrue: [ ^aStream nextPut: (Character value: 16r2261) ].
	self associations do: [ :k_v |
		aStream nextPut: $[.
		aStream nextPutAll: k_v key.
		aStream nextPutAll: ':='.
		k_v value printOn: aStream.
		aStream nextPut: $] ]
]

{ #category : #'as yet unclassified' }
Subst >> substitutionEnvironmentOver: aBindEnv [
	| substs |
	"TODO: code duplication with DelayedSubst"
	substs := self associations collect: [ :ass |
		(aBindEnv ctContext tempNamed: ass key) -> (aBindEnv evaluate: ass value) ].
	^Dictionary newFromAssociations: substs
]

{ #category : #'as yet unclassified' }
Subst >> update: kx symbol: sym [
	| ksym |
	ksym := sym kArgSymbol: kx.
	self associations do: [ :from_to | from_to key = sym ifTrue: [ 
			"Just z case in UniqifyKVars.hs"
			| z newAss |
			z := from_to value.
			newAss := ksym->z.
			^Subst mkSubst: ((self associations copyWithout: from_to) copyWith: newAss) ]].
	"Nothing"
	self shouldBeImplemented 
]
