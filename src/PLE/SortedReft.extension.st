Extension { #name : #SortedReft }

{ #category : #'*PLE' }
SortedReft >> strengthenSortedReft: e [
"
strengthenSortedReft :: SortedReft -> Expr -> SortedReft
strengthenSortedReft (RR s (Reft (v, r))) e = RR s (Reft (v, pAnd [r, e]))
"
	^self class
		sort: sr_sort
		reft: (Reft
			symbol: sr_reft symbol
			expr: (Bool and: { sr_reft expr. e }) )
]
