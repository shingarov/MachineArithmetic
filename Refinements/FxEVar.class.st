Class {
	#name : #FxEVar,
	#superclass : #Expr,
	#instVars : [
		'sym'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FxEVar class >> of: v [
	^self basicNew
		sym: v;
		yourself
]

{ #category : #comparing }
FxEVar >> = rhs [
	rhs class == self class ifFalse: [ ^false ].
	^sym = rhs sym
]

{ #category : #visiting }
FxEVar >> accept: aVisitor [
	^self
]

{ #category : #'as yet unclassified' }
FxEVar >> eApps: es [
"
eApps :: Expr -> [Expr] -> Expr
eApps f es  = foldl' EApp f es
"
	^es inject: self into: [ :soFar :e | FxEApp expr: soFar imm: e ]
]

{ #category : #'as yet unclassified' }
FxEVar >> ensureFreeVarsIn: kvEnv areKnownIn: be [
	be sortOf: sym "blow up if not already known"
]

{ #category : #compilation }
FxEVar >> evaluateIn: anEvalEnv [ 
	^anEvalEnv at: sym
]

{ #category : #comparing }
FxEVar >> hash [
	^sym hash
]

{ #category : #'as yet unclassified' }
FxEVar >> isConc [
	^true
]

{ #category : #comparing }
FxEVar >> isConstantNamed: s [
	^sym = s
]

{ #category : #'as yet unclassified' }
FxEVar >> isJunkFxEVar [
	^sym = String junkSymbol
]

{ #category : #'as yet unclassified' }
FxEVar >> isKVar [
	^false
]

{ #category : #'as yet unclassified' }
FxEVar >> kvarsExpr [
	^#()
]

{ #category : #'as yet unclassified' }
FxEVar >> not [
	^HPredNot of: self
]

{ #category : #printing }
FxEVar >> printOn: aStream [
	aStream nextPut: $«.
	aStream nextPutAll: sym.
	aStream nextPut: $».
]

{ #category : #'as yet unclassified' }
FxEVar >> rType [
	"F.Pred -> RType"
	^TBase
		b: TBool instance
		r: (Reft expr: self) known
]

{ #category : #'as yet unclassified' }
FxEVar >> readStream [
	^sym readStream
]

{ #category : #'as yet unclassified' }
FxEVar >> splitEApp [
"FIXME: Code duplication.
More generally, EApp, EVar should become Exprs."
	^Expr splitEApp: self
]

{ #category : #substitution }
FxEVar >> subSymbol: _ [
"
subSymbol :: Maybe Expr -> Symbol -> Symbol
subSymbol (Just (EVar y)) _ = y
"
	^sym
]

{ #category : #'F.Subable' }
FxEVar >> subst: θ [
	θ associations do: [ :ass | sym = ass key ifTrue: [ ^ass value ] ].
	^self
]

{ #category : #'F.Subable' }
FxEVar >> substPred: oldToNewVarNameAssocs [
	^self subst: (Subst mkSubstNameToName: oldToNewVarNameAssocs)
]

{ #category : #accessing }
FxEVar >> sym [
	^ sym
]

{ #category : #accessing }
FxEVar >> sym: anObject [
	sym := anObject
]

{ #category : #compilation }
FxEVar >> toInt [
	^sym toInt
]

{ #category : #'as yet unclassified' }
FxEVar >> uniq1: α [
	"BOGUS" 
	^self
]
