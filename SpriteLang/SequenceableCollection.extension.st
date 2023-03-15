Extension { #name : #SequenceableCollection }

{ #category : #'*SpriteLang' }
SequenceableCollection >> freshKVar [
"
freshKVar :: F.SrcSpan -> [F.Sort] -> CG F.Symbol
cf. Constraints.hs
"
	| k hVar |
	k := CGState current freshInt kVar.
	hVar := HVar name: k argSorts: self.
	CGState current addSrcKVar: hVar.
	^k
]
