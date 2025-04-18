Class {
	#name : #RTypeParser,
	#superclass : #RefinementParser,
	#category : #'SpriteLang-Parsing'
}

{ #category : #grammar }
RTypeParser >> annot [
	^   (self sigP: 'val')     ==> [ :x | Val  symbol: x first rtype: x second metric: x third ]
	/ ( (self sigP: 'reflect') ==> [ :x | Refl symbol: x first rtype: x second metric: x third ] )
	
]

{ #category : #grammar }
RTypeParser >> start [
	^self annot annotationBrackets trim
]
