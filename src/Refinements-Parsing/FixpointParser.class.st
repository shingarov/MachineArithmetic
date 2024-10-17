Class {
	#name : #FixpointParser,
	#superclass : #PPCompositeParser,
	#category : #'Refinements-Parsing'
}

{ #category : #grammar }
FixpointParser >> fixpoint [
	^'fixpoint' asParser trim,
	'"--' asParser,
	('eliminate' asParser / 'rewrite' asParser / 'save' asParser / 'fuel' asParser),
	($= asParser, #word asParser plus flatten) optional,
	$" asParser
	==> [ :x |
		| selector |
		selector := x third asSymbol.
		x fourth isNil
			ifTrue: [ HOpt perform: selector ]
			ifFalse: [ HOpt perform: selector, ':' with: x fourth second ]
	]
	
]
