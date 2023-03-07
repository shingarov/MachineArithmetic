Extension { #name : #PureFormula }

{ #category : #'*SpriteLang' }
PureFormula >> isRVarApp: anEvalEnv whichCameFrom: unevaluated [
	^Either right: unevaluated
]
