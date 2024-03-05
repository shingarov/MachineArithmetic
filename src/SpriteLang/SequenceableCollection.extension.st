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
	CGInfo current addSrcKVar: hVar.
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

{ #category : #'*SpriteLang' }
SequenceableCollection >> tripletsDo: aBlock [
	"Evaluate aBlock with my elements taken three at a time.  If number of items is not multiple of 3, ignore the last one(s).
	 Allows use of a flattened array for things that naturally group into triplets.  See also pairsDo:"

	0 to: self size // 3 - 1 do:
		[ :index |
			aBlock value: (self at: 3 * index + 1)
						value: (self at: 3 * index + 2)
						value: (self at: 3 * index + 3) ]
]
