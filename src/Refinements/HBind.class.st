"
--------------------------------------------------------------------------------
-- | @Cst@ is an NNF Horn Constraint. 
-------------------------------------------------------------------------------
-- Note that a @Bind@ is a simplified @F.SortedReft@ ...
data Bind = Bind
  { bSym  :: !F.Symbol 
  , bSort :: !F.Sort
  , bPred :: !Pred
  }
  deriving (Data, Typeable, Generic, Eq)
  
Cf. Horn/Types.hs
"
Class {
	#name : #HBind,
	#superclass : #Object,
	#instVars : [
		'x',
		'τ',
		'p'
	],
	#category : #'Refinements-Horn'
}

{ #category : #naming }
HBind class >> dummy [
	^self x: self dummyName τ: Int sort p: (HPredAnd of: #())
]

{ #category : #naming }
HBind class >> dummyName [
	^'LIQUIDßdummy'
]

{ #category : #'instance creation' }
HBind class >> x: x τ: τ p: p [
	^self basicNew 
		x: x;
		τ: τ;
		p: p;
		yourself 
]

{ #category : #'as yet unclassified' }
HBind >> bindSortedReft: kve [
	^SortedReft 
		sort: τ
		reft: (Reft symbol: x expr: (p predExpr: kve))
]

{ #category : #accessing }
HBind >> p [
	^ p
]

{ #category : #accessing }
HBind >> p: anObject [
	p := anObject
]

{ #category : #printing }
HBind >> printOn: aStream [
	aStream nextPutAll: self x.
	aStream nextPutAll: ':'.
	τ printOn: aStream.
	aStream nextPutAll: ' | '.
	self p printOn: aStream
]

{ #category : #'as yet unclassified' }
HBind >> uBind: α [
	| x′ p′ |
	x′ := α uVariable: x.
	p′ := α rename: p.
	^HBind x: x′ τ: τ p: p′
]

{ #category : #accessing }
HBind >> x [
	^ x
]

{ #category : #accessing }
HBind >> x: anObject [
	x := anObject
]

{ #category : #accessing }
HBind >> τ [
	^ τ
]

{ #category : #accessing }
HBind >> τ: anObject [
	τ := anObject
]
