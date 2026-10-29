Extension { #name : #Collection }

{ #category : #'*PLE' }
Collection >> efAll: f [
	| xs′_fe xs′ fe |
	xs′_fe := self feSeq.
	xs′ := xs′_fe key.  fe := xs′_fe value.
	^f∘xs′ -> fe
]

{ #category : #'*PLE' }
Collection >> feAny [
"
feAny :: [FinalExpand] -> FinalExpand
feAny xs = FE $ any feVal xs
"
	^self anySatisfy: #yourself
]

{ #category : #'*PLE' }
Collection >> feSeq [
"
feSeq :: [(Expr, FinalExpand)] -> ([Expr], FinalExpand)
feSeq xs = (map fst xs, feAny (map snd xs))
"
	^(self collect: #key) ->
	 (self collect: #value) feAny
]
