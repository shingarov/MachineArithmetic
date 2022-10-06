Class {
	#name : #FTycon,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #'type algebra' }
FTycon >> fAppTC: argSorts [
	"fAppTC :: FTycon -> [Sort] -> Sort"
	^self sort fApp: argSorts
]
