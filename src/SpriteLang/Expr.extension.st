Extension { #name : #Expr }

{ #category : #'*SpriteLang' }
Expr >> gtBind [
	^''
]

{ #category : #'*SpriteLang' }
Expr >> gtExpr [
	^self
]

{ #category : #'*SpriteLang' }
Expr >> isLet [
	^false
]

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
	^self predReft known
]
