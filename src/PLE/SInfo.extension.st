Extension { #name : #SInfo }

{ #category : #'*PLE' }
SInfo >> instEnv: cs z3: ctx [
"
Step 1a: Set up the incremental-PLE environment
instEnv :: (Loc a) => Config -> SInfo a -> CMap (SimpC a) -> SMT.Context -> InstEnv a
                       cfg       fi         cs                ctx
"
	| γ s₀ |
	γ := Knowledge of: self.
	s₀ := EvalEnvPLE fromSymEnv: ctx ctxSymEnv.
	^InstEnv
		ieCfg: #cfg
		ieSMT: ctx
		ieBEnv: bs
		ieAenv: ae
		ieCstrs: cs
		ieKnowl: γ
		ieEvEnv: s₀
]

{ #category : #'*PLE' }
SInfo >> instantiate: subcIds [
	"Strengthen Constraint Environments via PLE.

instantiate :: (Loc a) => Config -> SInfo a -> Maybe [SubcId] -> IO (SInfo a)
                           cfg      fi′=self      subcIds
Cf. PLE.hs (NOT Instantiate.hs which is the old one and doesn't pass ple0 test!)
"
	| sEnv aEnv cs fi t res |
	sEnv := self symbolEnv.
	sEnv naturalTransformations: gLits.
	fi := self normalizeIn: sEnv.
	aEnv := fi ae.
	cs := fi cm associations selectAssociations: [ :i :c | (aEnv isPleCstr: c sid: i) and: [
			subcIds ifNil: [ True ] ifNotNil: [ subcIds includes: i ] ] ].
	
	"1. BUILD the Trie"
	t := CTrie mkCTrie: cs.
	
	"2. TRAVERSE Trie to compute InstRes"
	res := [ :z3 | t pleTrie: (fi instEnv: cs z3: z3) ] withCtx: sEnv.
	res savePLEEqualities: fi.
	
	"3. STRENGTHEN SInfo using InstRes"
	sEnv := fi symbolEnv.
	^res resSInfo: fi symEnv: sEnv
]
