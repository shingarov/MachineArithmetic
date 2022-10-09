"
I am the superclass of all brain-damaged Sorts which are not Z3Sorts.
"
Class {
	#name : #PreSort,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
PreSort >> fApp: argSorts [
	"Same as in Z3Sort."
	^argSorts inject: self into: [ :x :y | FApp s: x t: y ]
]

{ #category : #'as yet unclassified' }
PreSort >> trueSortedReft [
	"Same as Z3Sort."
	^SortedReft 
		sort: self
		reft: (Reft expr: (DecidableRefinement always))
]
