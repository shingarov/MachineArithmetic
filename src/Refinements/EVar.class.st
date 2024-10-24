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

{ #category : #substitution }
EVar >> applyExpr: θ [ 
	^self
]

{ #category : #sanitizing }
EVar >> badArg: sEnv [
	^(sEnv includes: sym) not
]

{ #category : #'sort-checking' }
EVar >> checkANF [
]

{ #category : #'as yet unclassified' }
EVar >> eApps: es [
"
eApps :: Expr -> [Expr] -> Expr
eApps f es  = foldl' EApp f es
"
	^es inject: self into: [ :soFar :e | EApp expr: soFar imm: e ]
]

{ #category : #elaboration }
EVar >> elab: anElabEnv [
	"In LH this is a call to checkSym.
	 We can't do a stronger assert because our own sort
	 may be the  not-yet-evaluated polymorphic sort
	 (something like FAbs 0 ((FApp l @(0))→ℤ)) but someone
	 else might have already elaborated it (e.g. all the way
	 to a Z3Sort)."
	
	
	
	| sortInEnv instance |
	sortInEnv := anElabEnv senv sort at: sym.
	instance := sortInEnv instantiate.
	^{ EVar of: sym . instance }
]

{ #category : #uncurrying }
EVar >> elabApplyStep: γ [
	^self
]

{ #category : #compilation }
EVar >> evaluateIn: anEvalEnv ifUndeclared: vndBlock [
	^anEvalEnv at: sym "Create an UnknownEVar, NOT raise ValueNotFound"
]

{ #category : #accessing }
EVar >> functorName [
	^sym
]

{ #category : #GT }
EVar >> gtChildren [
	^{}
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
EVar >> kvarsExpr [
	^#()
]

{ #category : #inlining }
EVar >> macroExpandEVar: x to: aΛExpr [
	^x = sym
		ifTrue: [ aΛExpr ]
		ifFalse: [ self ]
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

{ #category : #'SMT interface' }
EVar >> smt2 [
	| preSort z3sort |
	preSort := (Context readState: #symbolEnv) sort at: sym.
	z3sort := preSort z3sort.
	^z3sort mkConst: sym
]

{ #category : #'SMT interface' }
EVar >> smt2Cast: t in: γ [
	^t mkZ3const: sym
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
EVar >> toZ3Sort: s [ 
	^s mkConst: sym
]

{ #category : #'as yet unclassified' }
EVar >> uniq1: α [
	"BOGUS" 
	^self
]

{ #category : #'function application' }
EVar >> valueWithArguments: args [
	^args inject: self into: [ :acc :thisArg | EApp expr: acc imm: thisArg ]
]
