Extension { #name : #DataDecl }

{ #category : #'*PLE' }
DataDecl >> reWriteDDecl [
"
reWriteDDecl :: DataDecl -> [Rewrite]
Cf. Solver/PLE.hs
"
	^ddCtors >>= #goReWriteDDecl
]
