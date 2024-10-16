Class {
	#name : #FQParser,
	#superclass : #FixpointParser,
	#instVars : [
		'subC',
		'sortedReft'
	],
	#category : #'Refinements-Parsing'
}

{ #category : #grammar }
FQParser >> constraint [
	^ 'constraint:' asParser trim
	, subC
]

{ #category : #grammar }
FQParser >> def [
	^ self fixpoint
	/ self constraint
	/ 'everything else' asParser
]

{ #category : #grammar }
FQParser >> fInfo [
	^ self def plus
	==> [ :x | FInfo defsFInfo: x ]
]

{ #category : #grammar }
FQParser >> sortedReft [

]

{ #category : #grammar }
FQParser >> start [
	^self fInfo
]

{ #category : #grammar }
FQParser >> subC [
	^ 'env []' asParser trim
	, "'lhs' asParser trim, sortedReft
	, 'rhs' asParser trim," sortedReft trim
	, 'id'  asParser, Character space asParser plus, PPParser decimalNat trim
	, self tag
	==> [ :x | x halt ]
]

{ #category : #grammar }
FQParser >> tag [
	^ 'tag' asParser
	, Character space asParser
	, PPParser decimalNat semicolonSeparated brackets
	==> [ :x | x third ]
]
