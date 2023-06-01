Extension { #name : #RBMethodNode }

{ #category : #'*MustBeBooleanMagic' }
RBMethodNode >> rewriteTempsForMustBeBooleanMagicContext: aContext [
	| rewriter methodVars contextOnlyTemps |
	rewriter := RBParseTreeRewriter new.
	methodVars := self allDefinedVariables collect: [ :var | var asString ].
	contextOnlyTemps := aContext tempNames difference: methodVars.
	aContext tempNames do:
			[ :tempName | 
			(contextOnlyTemps includes: tempName)
				ifTrue:
					[ rewriter
						replace: tempName , ' := ``@object' with: 'ThisContext tempNamed: ', tempName asString printString  , ' put: ``@object';
						replace: tempName with: 'ThisContext tempNamed: ' , tempName asString printString ] ].
	^ rewriter
		executeTree: self;
		tree
]
