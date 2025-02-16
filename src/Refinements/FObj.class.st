Class {
	#name : #FObj,
	#superclass : #PreSort,
	#instVars : [
		'symbol'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FObj class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
FObj class >> symbol: s [
	^self basicNew
		symbol: s;
		yourself
]

{ #category : #comparing }
FObj >> = rhs [
	self class = rhs class ifFalse: [ ^false ].
	^symbol = rhs symbol
]

{ #category : #'sort algebra' }
FObj >> checkEqConstr: f maybeExpr: e tvSubst: θ symbol: a [
"
checkEqConstr _ _  θ a (FObj b)
  | a == b
  = return θ
"
	^symbol = a
		ifTrue: [ θ ]
		ifFalse: [ super checkEqConstr: f maybeExpr: e tvSubst: θ symbol: a ]
]

{ #category : #'as yet unclassified' }
FObj >> checkNumeric: f tvSubst: aCollection [
"
checkNumeric :: Env -> Sort -> CheckM ()
                 f     s@FObj(l)     ← s=self, l=symbol
checkNumeric f s@(FObj l)
  = do t <- checkSym f l
       unless (t `elem` [FNum, FFrac, intSort, FInt]) (throwErrorAt $ errNonNumeric s)
"
	| t |
	t := f checkSym: symbol.
	t isIntSort ifFalse: [ NonNumericSort signalForSort: t ].
	^nil
]

{ #category : #'sort algebra' }
FObj >> containsFVar [
	^false
]

{ #category : #hotel }
FObj >> fappSmtSort: ts originalFApp: anFApp in: _ [
	| monomorphicSortName |
	monomorphicSortName := ts isEmpty ifTrue: [
		symbol
	] ifFalse: [
		(ts inject: '(', symbol into: [ :soFar :t | soFar, ' ', t monomorphicSortName ]),
		')'
	].
	PreSort hotel at: monomorphicSortName putNoSmash: anFApp.
	^Z3Sort uninterpretedSortNamed: monomorphicSortName encodeUnsafe

]

{ #category : #comparing }
FObj >> hash [
	^symbol hash
]

{ #category : #'as yet unclassified' }
FObj >> maybeExistingSortIn: env [
"
tx t@(FObj a) = fromMaybe t (F.lookupSEnv a env)
Cf. Smt/Interface.hs
"
	^(env lookupSEnv: symbol)
		ifNil: [ Z3Sort uninterpretedSortNamed: symbol ]
		ifNotNil: #yourself
]

{ #category : #hotel }
FObj >> monomorphicSortName [
	^symbol
]

{ #category : #printing }
FObj >> printOn: aStream [
	aStream
		nextPutAll: 'FObj(';
		nextPutAll: symbol;
		nextPutAll: ')'
]

{ #category : #substitution }
FObj >> sortSubst: θ [ 
	^θ at: symbol
]

{ #category : #substitution }
FObj >> subst: j _: tj [ 
	^self
]

{ #category : #accessing }
FObj >> symbol [
	^ symbol
]

{ #category : #accessing }
FObj >> symbol: anObject [
	symbol := anObject
]

{ #category : #hotel }
FObj >> uninterpretedZ3Sort [
	PreSort hotel at: symbol putNoSmash: self.
	^Z3Sort uninterpretedSortNamed: symbol
	
]

{ #category : #hotel }
FObj >> z3sort: γ [
	^(γ sort lookupSEnv: symbol)
		ifNil: [ self uninterpretedZ3Sort ]
		ifNotNil: [ :s | s = self ifTrue: [ s ] ifFalse: [ s z3sort: γ ] ]
]
