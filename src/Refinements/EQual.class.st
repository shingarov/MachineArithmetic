Class {
	#name : #EQual,
	#superclass : #Object,
	#instVars : [
		'qual',
		'pred',
		'args'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EQual class >> new [
	self shouldNotImplement 
]

{ #category : #'instance creation' }
EQual class >> qual: qual pred: pred args: args [
	^self basicNew qual: qual; pred: pred; args: args; yourself 
]

{ #category : #comparing }
EQual >> = anotherEQual [
	^super = anotherEQual "BOGUS"
]

{ #category : #accessing }
EQual >> args [
	^ args
]

{ #category : #accessing }
EQual >> args: anObject [
	args := anObject
]

{ #category : #'as yet unclassified' }
EQual >> evaluateIn: aBindEnv ifUndeclared: vndBlock [
	^EQual
		qual: (qual evaluateIn: aBindEnv ifUndeclared: vndBlock)
		pred: (pred evaluateIn: aBindEnv ifUndeclared: vndBlock)
		args: (args collect: [ :arg | arg evaluateIn: aBindEnv ifUndeclared: vndBlock])
]

{ #category : #'as yet unclassified' }
EQual >> okInst: sortEnv symbol: v sort: t [
"okInst :: F.SEnv F.Sort -> F.Symbol -> F.Sort -> Sol.EQual -> Bool
cf. Solution.hs"
	| p sr tc |
	p := pred.
	sr := SortedReft sort: t reft: (Reft symbol: v expr: p).
	"tc := sr checkSorted: sortEnv."
	
	"tc shouldBeImplemented."
	^true "TODO"
]

{ #category : #accessing }
EQual >> pred [
	^ pred
]

{ #category : #accessing }
EQual >> pred: anObject [
	pred := anObject
]

{ #category : #accessing }
EQual >> qual [
	^ qual
]

{ #category : #accessing }
EQual >> qual: anObject [
	qual := anObject
]
