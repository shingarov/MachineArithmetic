Class {
	#name : #RTypeParser,
	#superclass : #RefinementParser,
	#category : #'SpriteLang-Parsing'
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
RTypeParser >> start [
	^self ann
]
