"
type KvDom     = M.HashMap F.KVar (F.SEnv F.BindId)

Cf. Solver/Sanitize.hs
"
Class {
	#name : #KvDom,
	#superclass : #Dictionary,
	#category : #'Refinements-Solver'
}

{ #category : #sanitizing }
KvDom >> restrictWf: k wfc: w [
"
Restrict the env of `w` to the parameters in `kve k`.
restrictWf :: KvDom -> F.KVar -> F.WfC a -> F.WfC a
              self      k         w
"
	| f kEnv kis |
	kEnv := self at: k ifAbsent: [ SEnv new ].
	kis := kEnv values asSet.
	f := [ :eachBindId | kis includes: eachBindId ].
	w env: (w env filterIBindEnv: f)
]
