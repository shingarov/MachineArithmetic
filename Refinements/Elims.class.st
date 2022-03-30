Class {
	#name : #Elims,
	#superclass : #Object,
	#instVars : [
		'depCuts',
		'depNonCuts'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Elims class >> cuts: c nonCuts: nc [
	^self basicNew 
		depCuts: c;
		depNonCuts: nc;
		yourself
]

{ #category : #'instance creation' }
Elims class >> new [
	^self
		cuts: Set new
		nonCuts: Set new
]

{ #category : #'as yet unclassified' }
Elims >> , anotherElims [ 
	^Elims
		cuts: (depCuts union: anotherElims depCuts)
		nonCuts: (depNonCuts union: anotherElims depNonCuts)
]

{ #category : #accessing }
Elims >> depCuts [
	^ depCuts
]

{ #category : #accessing }
Elims >> depCuts: anObject [
	depCuts := anObject
]

{ #category : #accessing }
Elims >> depNonCuts [
	^ depNonCuts
]

{ #category : #accessing }
Elims >> depNonCuts: anObject [
	depNonCuts := anObject
]

{ #category : #'as yet unclassified' }
Elims >> forceKuts: xs [
"
forceKuts :: (Hashable a, Eq a) => S.HashSet a -> Elims a  -> Elims a
"
 xs isEmpty ifFalse: [ self shouldBeImplemented ].
	^self
]
