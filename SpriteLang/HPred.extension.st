Extension { #name : #HPred }

{ #category : #'*SpriteLang' }
HPred >> rType [
	"F.Pred -> RType"
	^TBase
		b: TBool instance
		r: (Reft expr: self) known
]
