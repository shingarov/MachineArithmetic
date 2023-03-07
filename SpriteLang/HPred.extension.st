Extension { #name : #HPred }

{ #category : #'*SpriteLang' }
HPred >> predExprs [
"
predExprs :: H.Pred -> [F.Expr]
cf. Types.hs
"
	| flat |
	flat := self flatten.
	^(flat isKindOf: HPredAnd)
		ifTrue: [ flat conjuncts collectAndCat: #predExprsGo ]
		ifFalse: [ flat predExprsGo ]
]

{ #category : #'*SpriteLang' }
HPred >> rType [
	"F.Pred -> RType"
	^TBase
		b: TBool instance
		r: (Reft expr: self) known
]

{ #category : #'*SpriteLang' }
HPred >> refactorAppP: anEvalEnv [
	| es rs_fs rs fs |
	es := self predExprs.
	rs_fs := es mapEither: [ :e |
		| smalltalkObject |
		smalltalkObject := e evaluateInventivelyIn: anEvalEnv.
		smalltalkObject isRVarApp: anEvalEnv whichCameFrom: e ].
	rs := rs_fs key.
	fs := rs_fs value.
	^HPredAnd of: fs, rs "BOGUS: what's with the Reft expr: (HPredAnd of: fs)?"
]

{ #category : #'*SpriteLang' }
HPred >> smash [
"
smash :: H.Pred -> [H.Pred]
smash (H.PAnd ps) = concatMap smash ps
smash p           = [p]
"
	^{self}
]
