Extension { #name : #BlockClosure }

{ #category : #'*PLE' }
BlockClosure >> withCtx: env [
"
withCtx :: Config -> FilePath -> SymEnv -> (SMT.Context -> IO a) -> IO a
                                  env              self=k
cf. PLE.hs
"
	| ctx res |
	ctx := env makeContextWithSEnv.
	res := self value: ctx.
	ctx del.
	^res
]
