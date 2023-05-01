Class {
	#name : #RTypeParser,
	#superclass : #RefinementParser,
	#category : #SpriteLang
}

{ #category : #prelude }
RTypeParser class >> mkTy: s [
"
mkTy :: String -> RType
"
	| rt |
	rt := (self new productionAt: #rtype) parse: s.
	^rt generalize rebind
]

{ #category : #grammar }
RTypeParser >> annot [
	^   (self sigP: 'val')     ==> [ :x | Val  symbol: x first rtype: x second metric: x third ]
	/ ( (self sigP: 'reflect') ==> [ :x | Refl symbol: x first rtype: x second metric: x third ] )
	
]

{ #category : #grammar }
RTypeParser >> start [
	^self annot annotationBrackets trim
]
