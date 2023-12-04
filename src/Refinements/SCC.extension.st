Extension { #name : #SCC }

{ #category : #'*Refinements' }
SCC >> sccDep: f [
"
sccDep :: (Cutable a) =>  Cutter a -> G.SCC (a, a, [a]) -> Elims a
"
	self subclassResponsibility
]
