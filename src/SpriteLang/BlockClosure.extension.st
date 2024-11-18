Extension { #name : #BlockClosure }

{ #category : #'*SpriteLang' }
BlockClosure >> runCG [
"
run :: CG a -> Either [UX.UserError] (a, CGInfo)
run act = do
  (x, s) <- runStateT act s0
  return (x, cgInfo s)
Cf. Constraints.hs
"
	| x s |
	s := CGState s0.
	x := self runReader: #cgi initialState: s.
	^x -> s cgInfo
]
