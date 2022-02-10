Extension { #name : #HVar }

{ #category : #'*Refinements-Parsing' }
HVar class >> parser [
	^'var' asParser trim,
	self kappaParser trim,
	self sortParser parens trim plus parens
	==> [ :x | HVar name: x second argSorts: x third ]
	
]
