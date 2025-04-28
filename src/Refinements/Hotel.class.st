Class {
	#name : #Hotel,
	#superclass : #Dictionary,
	#type : #variable,
	#instVars : [
		'fApps'
	],
	#category : #'Refinements-SortCheck'
}

{ #category : #'FApp back mapping' }
Hotel >> fApps [
	fApps isNil ifTrue: [ fApps := Dictionary new ].
	^ fApps
]

{ #category : #'FApp back mapping' }
Hotel >> noteFAppFor: aZ3Sort was: aPreSort [
	self fApps at: aZ3Sort put: aPreSort
]

{ #category : #'FApp back mapping' }
Hotel >> recallFAppFor: aZ3Sort [ 
	^self recallFAppFor: aZ3Sort ifNotFound: [ self errorKeyNotFound: aZ3Sort ]
]

{ #category : #'FApp back mapping' }
Hotel >> recallFAppFor: aZ3Sort ifNotFound: failBlock [
	^fApps at: aZ3Sort ifAbsent: [^failBlock value]
]
