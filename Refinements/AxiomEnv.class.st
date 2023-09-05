"
---------------------------------------------------------------------------
-- | Axiom Instantiation Information --------------------------------------
---------------------------------------------------------------------------
data AxiomEnv = AEnv
  { aenvEqs      :: ![Equation]
  , aenvSimpl    :: ![Rewrite] 
  , aenvExpand   :: M.HashMap SubcId Bool
  , aenvAutoRW   :: M.HashMap SubcId [AutoRewrite]
  } deriving (Eq, Show, Generic)
"
Class {
	#name : #AxiomEnv,
	#superclass : #Object,
	#instVars : [
		'aenvEqs',
		'aenvSimpl',
		'aenvExpand',
		'aenvAutoRW'
	],
	#category : #'Refinements-Reflection'
}

{ #category : #'instance creation' }
AxiomEnv class >> aenvEqs: eqs aenvSimpl: simpl aenvExpand: expand aenvAutoRW: autoRW [
	^self basicNew
		aenvEqs: eqs;
		aenvSimpl: simpl;
		aenvExpand: expand;
		aenvAutoRW: autoRW;
		yourself
]

{ #category : #'instance creation' }
AxiomEnv class >> new [
	"instance Monoid AxiomEnv where mempty = ..."
	^self
		aenvEqs: #()
		aenvSimpl: #()
		aenvExpand: Dictionary new
		aenvAutoRW: Dictionary new
]

{ #category : #Semigroup }
AxiomEnv >> , a2 [
	"instance Semigroup AxiomEnv where a1 <> a2 = ..."
	self shouldBeImplemented
]

{ #category : #accessing }
AxiomEnv >> aenvAutoRW [
	^ aenvAutoRW
]

{ #category : #accessing }
AxiomEnv >> aenvAutoRW: anObject [
	aenvAutoRW := anObject
]

{ #category : #accessing }
AxiomEnv >> aenvEqs [
	^ aenvEqs
]

{ #category : #accessing }
AxiomEnv >> aenvEqs: anObject [
	aenvEqs := anObject
]

{ #category : #accessing }
AxiomEnv >> aenvExpand [
	^ aenvExpand
]

{ #category : #accessing }
AxiomEnv >> aenvExpand: anObject [
	aenvExpand := anObject
]

{ #category : #accessing }
AxiomEnv >> aenvSimpl [
	^ aenvSimpl
]

{ #category : #accessing }
AxiomEnv >> aenvSimpl: anObject [
	aenvSimpl := anObject
]

{ #category : #'as yet unclassified' }
AxiomEnv >> isPleCstr: c sid: sid [
"
isPleCstr :: AxiomEnv -> SubcId -> SimpC a -> Bool
             aenv=self    sid        c

"
	^c isTarget and: [ aenvExpand at: sid ifAbsent: [false] ]
]
