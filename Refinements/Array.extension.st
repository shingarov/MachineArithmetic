Extension { #name : #Array }

{ #category : #'*Refinements' }
Array >> matchP: env is: is qualParams: qualParams [
"
matchP :: So.Env -> [(SortIdx, F.Sort, a)] -> [(SortIdx, QualPattern)] -> [F.QualParam] -> [[(SortIdx, QualPattern)]]
          env       tyss=self                 is                          qualParams
"
	| qp qps su_i_pat′s |
	qualParams isEmpty ifTrue: [ ^{is} ].
	qp := qualParams first.  qps := qualParams allButFirst.
	su_i_pat′s := QCluster candidatesP: env _: self _: qp.
	^su_i_pat′s collectTriplesAndCat: [ :su :i :pat |
			self matchP: env is: {{i.pat}},is qualParams: (qps collect: [ :each | each applyQPP: su ]) ]
]

{ #category : #'*Refinements' }
Array >> toProduct [
	^self as: Product
]
