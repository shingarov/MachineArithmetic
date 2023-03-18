Extension { #name : #Expr }

{ #category : #'*SpriteLang' }
Expr >> predRType [
"
predRType :: F.Pred -> RType
predRType p = TBase TBool (known $ F.predReft p)
"
	^TBase
		b: TBool instance
		r: self "F."predReft known
]

{ #category : #'*SpriteLang' }
Expr >> ΛpredReft [
	^KnownReft symbol: String dummySymbol expr: (HReft expr: self) 
]
