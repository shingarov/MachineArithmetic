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
