Extension { #name : #AxiomEnv }

{ #category : #'*PLE' }
AxiomEnv >> normalizeIn: sEnv [
"
normalize aenv = aenv { aenvEqs   = normalize <$> aenvEqs   aenv
                      , aenvSimpl = normalize <$> aenvSimpl aenv }
"
	aenvSimpl isEmpty ifFalse: [ self shouldBeImplemented ].
	^self copy
		aenvEqs: (aenvEqs collect: [ :eq | eq normalizeIn: sEnv ]);
		yourself
]
