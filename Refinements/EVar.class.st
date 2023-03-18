Class {
	#name : #EVar,
	#superclass : #Expr,
	#instVars : [
		'sym'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EVar class >> of: v [
	^self basicNew
		sym: v;
		yourself
]

{ #category : #comparing }
EVar >> = rhs [
	rhs class == self class ifFalse: [ ^false ].
	^sym = rhs sym
]

{ #category : #visiting }
EVar >> accept: aVisitor [
	^self
]

{ #category : #'as yet unclassified' }
EVar >> eApps: es [
"
eApps :: Expr -> [Expr] -> Expr
eApps f es  = foldl' EApp f es
"
	^es inject: self into: [ :soFar :e | EApp expr: soFar imm: e ]
]

{ #category : #compilation }
EVar >> evaluateIn: anEvalEnv [ 
	^anEvalEnv at: sym
]

{ #category : #comparing }
EVar >> hash [
	^sym hash
]

{ #category : #'as yet unclassified' }
EVar >> isConc [
	^true
]

{ #category : #comparing }
EVar >> isConstantNamed: s [
	^sym = s
]

{ #category : #'as yet unclassified' }
EVar >> isKVar [
	^false
]

{ #category : #'as yet unclassified' }
EVar >> kvarsExpr [
	^#()
]

{ #category : #'as yet unclassified' }
EVar >> not [
	^PNot of: self
]

{ #category : #printing }
EVar >> printOn: aStream [
	aStream nextPut: $«.
	aStream nextPutAll: sym.
	aStream nextPut: $».
]

{ #category : #'as yet unclassified' }
EVar >> readStream [
	^sym readStream
]

{ #category : #'as yet unclassified' }
EVar >> splitEApp [
"FIXME: Code duplication.
More generally, EApp, EVar should become Exprs."
	^Expr splitEApp: self
]

{ #category : #substitution }
EVar >> subSymbol: _ [
"
subSymbol :: Maybe Expr -> Symbol -> Symbol
subSymbol (Just (EVar y)) _ = y
"
	^sym
]

{ #category : #'F.Subable' }
EVar >> subst: θ [
	θ associations do: [ :ass | sym = ass key ifTrue: [ ^ass value ] ].
	^self
]

{ #category : #'F.Subable' }
EVar >> substPred: oldToNewVarNameAssocs [
	^self subst: (Subst mkSubstNameToName: oldToNewVarNameAssocs)
]

{ #category : #accessing }
EVar >> sym [
	^ sym
]

{ #category : #accessing }
EVar >> sym: anObject [
	sym := anObject
]

{ #category : #compilation }
EVar >> toInt [
	^sym toInt
]

{ #category : #'as yet unclassified' }
EVar >> uniq1: α [
	"BOGUS" 
	^self
]
