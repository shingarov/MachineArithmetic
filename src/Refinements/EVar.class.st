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

{ #category : #'sort-checking' }
EVar >> checkExpr: f [
"
checkExpr f (EVar x)       = checkSym f x
"
	^f checkSym: sym
]

{ #category : #'as yet unclassified' }
EVar >> eApps: es [
"
eApps :: Expr -> [Expr] -> Expr
eApps f es  = foldl' EApp f es
"
	^es inject: self into: [ :soFar :e | EApp fun: soFar imm: e ]
]

{ #category : #'sort-checking' }
EVar >> eCstAtom: t inElabEnv: f [
"
eCstAtom f@(sym,g) (EVar x) t
"
	| sym_ g |
	sym_ := f senv.
	g := f env.
	^g∘sym
		ifFound: [ :s | (s isUndef and: [(sym_ isInt: t) not])
			ifTrue: [ self shouldBeImplemented ]
			ifFalse: [ super eCstAtom: t inElabEnv: f ] ]
		alts: [ super eCstAtom: t inElabEnv: f ]
]

{ #category : #elaboration }
EVar >> elab: anElabEnv [
"
elab (_, f) e@(EVar x) =
  (e,) <$> checkSym f x
"
	^{ self . (anElabEnv env checkSym: sym) }
]

{ #category : #uncurrying }
EVar >> elabApplyStep: γ [
	^self
]

{ #category : #compilation }
EVar >> evaluateIn: anEvalEnv ifUndeclared: vndBlock [
	^anEvalEnv at: sym "Create an UnknownEVar, NOT raise ValueNotFound"
]

{ #category : #compilation }
EVar >> evaluateInventivelyIn: _ [ 
	^self
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

{ #category : #theories }
EVar >> ifUninterpreted: uninterpBlock ifInterpreted: interpBlock in: aSymEnv [
	^(aSymEnv theory lookupSEnv: sym)
		ifNil: [ uninterpBlock value ]
		ifNotNil: [ :aTheorySymbol | interpBlock value: aTheorySymbol ]
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
EVar >> smt2: γ [
	| preSort |
	preSort := γ sort at: sym.
	^self smt2Cast: preSort in: γ
]

{ #category : #'SMT interface' }
EVar >> smt2Cast: t in: γ [
	^self
		ifUninterpreted: [ t mkZ3const: sym in: γ ]
		ifInterpreted: [ :aTheorySymbol | aTheorySymbol tsInterp apply: sym to: #() ofZ3sorts: #() returning: (t z3sort: γ) ]
		in: γ
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
	^args inject: self into: [ :acc :thisArg | EApp fun: acc imm: thisArg ]
]
