Extension { #name : #HPred }

{ #category : #'*SpriteLang' }
HPred >> rType [
	"F.Pred -> RType"
	^TBase
		b: TBool instance
		r: (Reft expr: self) known
]

{ #category : #'*SpriteLang' }
HPred >> smash [
"
smash :: H.Pred -> [H.Pred]
smash (H.PAnd ps) = concatMap smash ps
smash p           = [p]
"
	^{self}
]
