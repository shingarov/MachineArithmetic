Class {
	#name : #SEnv,
	#superclass : #Dictionary,
	#category : #Refinements
}

{ #category : #environments }
SEnv >> at: x insert: v [
"
insertSEnv :: Symbol -> a -> SEnv a -> SEnv a
insertSEnv x v (SE env) = SE (M.insert x v env)
"
	^self copy
		at: x put: v;
		yourself
]

{ #category : #environments }
SEnv >> deleteSEnv: x [
"
deleteSEnv :: Symbol -> SEnv a -> SEnv a
deleteSEnv x (SE env)   = SE (M.delete x env)
"
	^self withoutKeys: {x}
]

{ #category : #'as yet unclassified' }
SEnv >> freezeNaturalTransformationsIn: aSymEnv [ 
	self keysAndValuesDo: [ :funcName :α | self at: funcName put: (α freezeIn: aSymEnv) ]
]

{ #category : #theories }
SEnv >> isSmt2App: anEVar [ 
"
isSmt2App :: SEnv TheorySymbol -> Expr -> Maybe Int
"
	| f |
	(anEVar isKindOf: EVar) ifFalse: [ ^nil ]. "isSmt2App _ _ = Nothing"
	f := anEVar sym.
	^(self lookupSEnv: f)
		ifNil: [ nil ]
		ifNotNil: #thyAppInfo
]

{ #category : #environments }
SEnv >> lookupSEnv: x [
"
lookupSEnv :: Symbol -> SEnv a -> Maybe a
lookupSEnv x (SE env)   = M.lookup x env
"
	^self at: x ifAbsent: [ nil ]
]

{ #category : #'*Refinements' }
SEnv >> lookupSEnvWithDistance: key [
	^Found x: (self at: key ifAbsent: [ ^Alts shouldBeImplemented  ])

]

{ #category : #environments }
SEnv >> standardLookupSEnv [
	^(self lookupSEnvWithDistance: □) as: Env.
]

{ #category : #'SMT interface' }
SEnv >> symbolSorts [
"
symbolSorts :: F.SEnv F.Sort -> [(F.Symbol, F.Sort)]
Cf. Smt/Interface.hs
Note that this is not the same as Solver.Sanitize.symbolSorts!
"
	^self associations collectAssociations: [ :x :t | x -> (t maybeExistingSortIn: self) ]
]

{ #category : #theories }
SEnv >> takeArgs: e es: es [
"
takeArgs :: SEnv TheorySymbol -> Expr -> [(Expr, a)] -> (Expr, [(Expr, a)])
Cf. SortCheck.hs
"
	(e isKindOf: ECst) ifFalse: [ self error ]. "in LH this is (Vis.stripCasts e) but control can only reach here with e=ECst(…)"
	^(self isSmt2App: e expr)
		ifNil: [ e -> es ]
		ifNotNil: [ :n |
			| es1_es2 es1 es2 |
			es1_es2 := es splitAt: n.
			es1 := es1_es2 key.  es2 := es1_es2 value.
			(e expr eApps: (es1 collect: #key)) -> es2
		]
]
