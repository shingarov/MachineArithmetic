Extension { #name : #PreSort }

{ #category : #'*SpriteLang' }
PreSort >> freshKVar: ts [
"freshKVar :: F.SrcSpan -> F.Sort -> [F.Sort] -> CG F.Symbol
cf. Constraints.hs

TODO: currently, this is code duplication with Z3Sort,
because freshKVar: doesn't care whether the sort is real or pre.
"
	| k hVar |
	k := CGState current freshInt kVar.
	hVar := HVar name: k argSorts: {self},ts.
	CGState current addSrcKVar: hVar.
	^k
]
