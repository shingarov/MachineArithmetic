Extension { #name : #EApp }

{ #category : #'*PLE' }
EApp >> goFastEval: γ ctx: ctx in: anEvalEnvPLE [
"
cf. PLE.hs
"
	| f_es f es f′_es′ f′ es′ |
	f_es := self splitEApp. f := f_es key. es := f_es value.
	f′_es′ := {f},es collect: [ :each | anEvalEnvPLE fastEval: γ ctx: ctx expr: each ].
	f′ := f′_es′ first. es′ := f′_es′ allButFirst.
	^γ evalApp: ctx f: f′ args: es′ in: anEvalEnvPLE
]
