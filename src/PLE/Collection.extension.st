Extension { #name : #Collection }

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
