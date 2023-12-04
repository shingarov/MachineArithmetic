Extension { #name : #SInfo }

{ #category : #'*PLE' }
SInfo >> instEnv: cs [
"
instEnv :: (Loc a) => Config -> SInfo a -> CMap (SimpC a) -> SMT.Context -> InstEnv a
                       cfg       fi         cs                ctx
"
	^InstEnv shouldBeImplemented new

]
