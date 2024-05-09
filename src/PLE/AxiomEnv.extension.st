Extension { #name : #AxiomEnv }

{ #category : #'*PLE' }
AxiomEnv >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite fastTable
		title: 'Equations';
		display: [ aenvEqs ];
		column: 'Name' evaluated: [ :each | each eqName ];
		column: 'Equation' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each ]
]

{ #category : #'*PLE' }
AxiomEnv >> isPleCstr: c sid: sid [
"
isPleCstr :: AxiomEnv -> SubcId -> SimpC a -> Bool
             aenv=self    sid        c

"
	^c isTarget and: [ aenvExpand at: sid ifAbsent: [false] ]
]

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
