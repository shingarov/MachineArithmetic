Extension { #name : #SInfo }

{ #category : #'*PLE' }
SInfo >> instEnv: cs [
"
Step 1a: Set up the incremental-PLE environment
instEnv :: (Loc a) => Config -> SInfo a -> CMap (SimpC a) -> SMT.Context -> InstEnv a
                       cfg       fi         cs                ctx
"
	| γ s₀ |
	γ := Knowledge of: self.
	s₀ := #EvalEnv  .
	^InstEnv
		ieCfg: #cfg
		ieSMT: #ctx
		ieBEnv: bs
		ieAenv: ae
		ieCstrs: cs
		ieKnowl: γ
		ieEvEnv: s₀
]
