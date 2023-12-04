Extension { #name : #Expr }

{ #category : #'*PLE' }
Expr >> askSMT: bs [
"
askSMT :: Config -> SMT.Context -> [(Symbol, Sort)] -> Expr -> IO Bool
           cfg        ctx           bs                  e
"
	| e′ |
	self isTautoPred ifTrue: [ ^true ].
	self kvarsExpr isEmpty ifFalse: [ ^false ].
	e′ := self toSMT: bs.
	^Z3Solver checkValidWithContext: #() p: 1 PTrue q: e′
	
	
]
