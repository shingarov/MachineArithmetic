Class {
	#name : #FQParser,
	#superclass : #FixpointParser,
	#category : #'Refinements-Parsing'
}

{ #category : #grammar }
FQParser >> def [
	^ self fixpoint
	/ self constraint
	/ 'everything else' asParser
]

{ #category : #accessing }
FQParser >> fInfo [
	^ self def plus
	==> [ :x | FInfo defsFInfo: x ]
]

{ #category : #accessing }
FQParser >> start [
	^self fInfo
]
