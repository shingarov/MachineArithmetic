Extension { #name : #GTPlayground }

{ #category : #'*Refinements-Tools' }
GTPlayground class >> contextMenuSMT2ActionsFor: aPlayground [
	<playgroundContextMenu>
	
	^ aPlayground codePresentation smt2Actions
]
