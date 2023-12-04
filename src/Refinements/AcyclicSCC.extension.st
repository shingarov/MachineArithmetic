Extension { #name : #AcyclicSCC }

{ #category : #'*Refinements' }
AcyclicSCC >> sccDep: f [ 
	^v third dNonCut
]
