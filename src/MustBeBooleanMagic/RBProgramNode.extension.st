Extension { #name : #RBProgramNode }

{ #category : #'*MustBeBooleanMagic' }
RBProgramNode >> mustBeBooleanMagicDoitForContext: aContext [
	"The VM can only evaluate methods. wrap this ast in a doitIn MethodNode to evaluate in a context"
	| methodNode |
	
	methodNode := RBMethodNode 
		selector: #DoItIn:
		arguments: { RBVariableNode named: 'ThisContext' } 
		body: self asSequenceNode transformLastToReturn.
	
	methodNode methodClass: aContext receiver class.
	methodNode rewriteTempsForMustBeBooleanMagicContext: aContext.
	methodNode source: methodNode formattedCode.
	^methodNode
]
