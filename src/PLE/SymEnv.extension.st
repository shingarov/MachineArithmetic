Extension { #name : #SymEnv }

{ #category : #'*PLE' }
SymEnv >> makeContextWithSEnv [
"
makeContextWithSEnv :: Config -> FilePath -> SymEnv -> IO Context
                        cfg          f      env=self
Here our Smalltalk implementation differs from upstream FX, we in-process call libz3 over FFI.
"
	^SMTContext with: self
]
