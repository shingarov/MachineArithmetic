Extension { #name : #OCASTClosureAnalyzer }

{ #category : #'*Refinements-SmalltalkSyntax-II' }
OCASTClosureAnalyzer >> visitArgumentNode: aVariableNode [
	aVariableNode acceptClosureAnalyzer: self.
	aVariableNode adaptToSemanticNode
]
