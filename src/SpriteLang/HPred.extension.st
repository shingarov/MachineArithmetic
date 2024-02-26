Extension { #name : #HPred }

{ #category : #'*SpriteLang' }
HPred >> pTrivial [
"
pTrivial :: H.Pred -> Bool
"
	^false
]

{ #category : #'*SpriteLang' }
HPred >> predExprs [
"
predExprs :: H.Pred -> [F.Expr]
cf. Types.hs
"
	| flat |
	flat := self flatten.
	(flat isKindOf: HPredAnd) ifTrue: [ ^flat ps collectAndCat: #predExprsGo ].
	^flat predExprsGo
]

{ #category : #'*SpriteLang' }
HPred >> refactorAppP: anEvalEnv [ 
	| es rs_fs rs fs |
	es := self predExprs.
	rs_fs := es mapEither: [ :e |
		| smalltalkObject |
		smalltalkObject := e evaluateInventivelyIn: anEvalEnv.
		smalltalkObject isRVarApp: anEvalEnv whichCameFrom: e ].
	rs := rs_fs key.   "<- these are κ-applications"
	fs := rs_fs value. "<- these are plain applications"
	^HPredAnd of: {HReft expr: (PAnd of: fs)}, rs
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

{ #category : #'*SpriteLang' }
HPred >> subsAR: p ar: ar [
	^self "No κ-apps can happen, because those have been refactored to RefVarApps"
]

{ #category : #'*SpriteLang' }
HPred >> uniq2: α [
	"α-rename all variables. Returns a copy of receiver with all names unique."

	self shouldBeImplemented

]
