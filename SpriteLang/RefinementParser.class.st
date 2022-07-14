Class {
	#name : #RefinementParser,
	#superclass : #PPCompositeParser,
	#category : #SpriteLang
}

{ #category : #grammar }
RefinementParser >> concReftB [
	^ self lowerId trim, $| asParser trim, self nonBracket plus flatten
	==> [ :id_pred |
			| id pred |
			id := id_pred first.
			pred := id_pred last.
			(Reft symbol: id expr: (DecidableRefinement text: pred)) known ]
]

{ #category : #'*SpriteLang' }
RefinementParser >> tvar [
	^ $' asParser, self lowerId
	==> [ :x | TVar symbol: x second ]
]
