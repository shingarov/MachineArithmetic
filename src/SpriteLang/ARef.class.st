"
-- | Abstract Refinements -----------------------------------------------------                   
data ARef r = ARef                                                                                
  { arArgs :: ![(F.Symbol, RSort)]                                                                
  , arPred :: r                                                                                   
  }                                                                                               
  deriving (Eq, Show, Functor)

-- | Proper refinement Types --------------------------------------------------
type RType = Type Reft
type RARef = ARef Reft                                                                            

-- | Sorts: types decorated with unit refinements -----------------------------                   
type RSort = Type ()
"
Class {
	#name : #ARef,
	#superclass : #Object,
	#instVars : [
		'arArgs',
		'arPred'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
ARef class >> arArgs: arArgs arPred: arPred [
	^self basicNew
		arArgs: arArgs;
		arPred: arPred;
		yourself
]

{ #category : #accessing }
ARef >> arArgs [
	^ arArgs
]

{ #category : #accessing }
ARef >> arArgs: anObject [
	arArgs := anObject
]

{ #category : #accessing }
ARef >> arPred [
	^ arPred
]

{ #category : #accessing }
ARef >> arPred: anObject [
	arPred := anObject
]

{ #category : #'as yet unclassified' }
ARef >> collect: f [
	"deriving Functor" 
	^ARef
		arArgs: (arArgs collectAssociations: [ :x :t | x -> (f ⊛ t) ])
		arPred: arPred
]

{ #category : #'as yet unclassified' }
ARef >> refactorAppR: anEvalEnv [
	| amendedEnv |
	amendedEnv := anEvalEnv,
		(EvalEnv constants: (arArgs collectAssociations: [ :argName :argRType | argName -> (DummyArg named: argName) ]) asDictionary).
	"deriving Functor"
	^ARef
		arArgs: (arArgs collectAssociations: [ :argName :argRType | argName -> (argRType refactorAppR: anEvalEnv) ])
		arPred: (arPred refactorAppR: amendedEnv)
]

{ #category : #'as yet unclassified' }
ARef >> subsAR: p ar: anARef [
	"bogus -- see Issue 62.  this one is especially screaming."
	^ARef
		arArgs: arArgs
		arPred: (arPred subsAR: p ar: anARef)
]

{ #category : #'as yet unclassified' }
ARef >> subsTy: su [
	| xts′ |
	xts′ := arArgs collectAssociations: [ :x :t | x -> (t subsTy: su) ].
	^ARef arArgs: xts′ arPred: arPred
]

{ #category : #'F.Subable' }
ARef >> subst: θ [
	^ARef
		arArgs: arArgs
		arPred: (arPred subst: θ)
]

{ #category : #'as yet unclassified' }
ARef >> tsubstGoA: outerT tVar: outerA [ 
	^self copy
		arArgs: ( arArgs collectAssociations: [ :x :t |
			x -> (t rSortToRType tsubstGo: outerT tVar: outerA) rTypeToRSort ])
]

{ #category : #'α-renaming' }
ARef >> uniq2: α [
	| α′ |

	α′ := α.
	arArgs do:[:a|α′ := α′ extMap: a key to: (α′ makeUnique:a key)].

	^self class
		arArgs: (arArgs collect:[:a|(α′ at: a key) -> (a value uniq2: α′)])
		arPred: (arPred uniq2: α′)
]

{ #category : #'as yet unclassified' }
ARef >> ≺+ rhs [
	| xts1 p1 xts2 p2 su |
	xts1 := arArgs. p1 := arPred expr. xts2 := rhs arArgs. p2 := rhs arPred expr.
	
	su := (xts2 collect: #key) zip: (xts1 collect: #key).
	^xts1 cImpl: p1 _: (p2 substs: su)
]
