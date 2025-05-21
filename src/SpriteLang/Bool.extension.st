Extension { #name : #Bool }

{ #category : #'*SpriteLang' }
Bool >> predRType [
"
predRType :: F.Pred -> RType
predRType p = TBase TBool (known $ F.predReft p)
"
	^TBase
		b: TBool instance
		r: self "F."predReft known
]
