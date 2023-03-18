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

{ #category : #'*SpriteLang' }
SequenceableCollection >> freshKVarReft [
"
freshKVarReft :: F.SrcSpan -> [RSort] -> CG RARef
cf. Check.hs
"
	| k |
	k := (self collect: #rSortToFSort) freshKVar.
	^(RVar rvName: k rvArgs: self) rVarARef__Types
]
