Extension { #name : #Z3Sort }

{ #category : #'*SpriteLang' }
Z3Sort >> freshKVar: ts [
"freshKVar :: F.SrcSpan -> F.Sort -> [F.Sort] -> CG F.Symbol
cf. Sprite/L3/Constraints.hs
"
	| k hVar |
	k := CGState current freshInt kVar.
	hVar := HVar name: k argSorts: {self},ts.
	CGState current addSrcKVar: hVar.
	^k
]

{ #category : #'*SpriteLang' }
Z3Sort >> sort_reft: knownDatatypes [ 
	^{self . 0}
]
