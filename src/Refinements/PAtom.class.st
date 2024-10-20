"
data Expr =
          ...
          | PAtom  !Brel  !Expr !Expr

data Brel = Eq | Ne | Gt | Ge | Lt | Le | Ueq | Une
            deriving (Eq, Ord, Show, Data, Typeable, Generic)

Regarding Ueq see remark in Solution.hs about ""we use ~~ because the param
and value may have different sorts, see: tests/pos/kvar-param-poly-00.hs""
"
Class {
	#name : #PAtom,
	#superclass : #Expr,
	#instVars : [
		'brel',
		'x',
		'y'
	],
	#pools : [
		'Brel'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
PAtom class >> brel: aSymbol x: x y: y [
	^self basicNew
		brel: aSymbol;
		x: x;
		y: y;
		yourself
]

{ #category : #'instance creation' }
PAtom class >> new [
	self shouldNotImplement
]

{ #category : #comparing }
PAtom >> = another [
	self class = another class ifFalse: [ ^false ].
	^ (brel = another brel)
	& (x = another x)
	& (y = another y)
]

{ #category : #'term rewriting' }
PAtom >> accept: aVisitor [
	^self class
		brel: brel
		x: (x accept: aVisitor)
		y: (y accept: aVisitor)
]

{ #category : #accessing }
PAtom >> brel [
	^ brel
]

{ #category : #accessing }
PAtom >> brel: anObject [
	(Brel classPool includes: anObject) ifFalse: [ self error ].
	brel := anObject
]

{ #category : #'term rewriting' }
PAtom >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
	^(x evaluateIn: aBindEnv ifUndeclared: vndBlock)
		perform: brel
		with: (y evaluateIn: aBindEnv ifUndeclared: vndBlock)
]

{ #category : #comparing }
PAtom >> hash [
	^brel hash
]

{ #category : #'term rewriting' }
PAtom >> isTautoPred [
	^brel = Eq and: [ x = y ]
]

{ #category : #printing }
PAtom >> printOn: aStream [
	aStream nextPut: $(.
	x printOn: aStream.
	aStream space.
	aStream nextPutAll: brel.
	aStream space.
	y printOn: aStream.
	aStream nextPut: $).
]

{ #category : #'term rewriting' }
PAtom >> subst1: θ [ 
	^PAtom
		brel: brel
		x: (x subst1: θ)
		y: (y subst1: θ)
]

{ #category : #'term rewriting' }
PAtom >> subst: θ [ 
	^PAtom
		brel: brel
		x: (x subst: θ)
		y: (y subst: θ)
]

{ #category : #'term rewriting' }
PAtom >> substPred: oldToNewVarNameAssocs [
	^self shouldBeImplemented "?"
]

{ #category : #accessing }
PAtom >> x [
	^ x
]

{ #category : #accessing }
PAtom >> x: anObject [
	x := anObject
]

{ #category : #accessing }
PAtom >> y [
	^ y
]

{ #category : #accessing }
PAtom >> y: anObject [
	y := anObject
]
