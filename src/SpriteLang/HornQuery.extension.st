Extension { #name : #HornQuery }

{ #category : #'*SpriteLang' }
HornQuery >> checkValidPLE [
"
checkValidPLE :: FilePath -> SrcQuery -> IO SrcResult
Cf. Common.hs
"
	| pleCfg |
	pleCfg := #TODO.
	^self checkValidWithCfg: pleCfg
]

{ #category : #'*SpriteLang' }
HornQuery >> checkValidWithCfg: cfg [
"
checkValidWithCfg :: FilePath -> FC.Config -> SrcQuery -> IO SrcResult
                                 cfg          self
Cf. Common.hs
"
	| q |
	q := self simplifyQuery.
	"dumpQuery f q"
	"fmap snd . F.resStatus <$> H.solve cfg q"
	^q solve
]

{ #category : #'*SpriteLang' }
HornQuery >> simplifyQuery [
"
simplifyQuery :: H.Query a -> H.Query a
"
	^self copy
		qCstr: qCstr simplifyConstraint
]
