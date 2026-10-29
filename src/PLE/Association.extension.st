Extension { #name : #Association }

{ #category : #'*PLE' }
Association >> mapFE: f [
"
mapFE :: (Expr -> Expr) -> (Expr, FinalExpand) -> (Expr, FinalExpand)
              f                self
mapFE f (e, fe) = (f e, fe)
"
	| e fe |
	e := self key. fe := self value.
	^f∘e -> fe
]
