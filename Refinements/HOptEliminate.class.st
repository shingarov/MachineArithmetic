"
-- | Eliminate describes the number of KVars to eliminate:
--   None = use PA/Quals for ALL k-vars, i.e. no eliminate
--   Some = use PA/Quals for CUT k-vars, i.e. eliminate non-cuts
--   All  = eliminate ALL k-vars, solve cut-vars to TRUE
--   Horn = eliminate kvars using the Horn solver
--   Existentials = eliminate kvars and existentials
"
Class {
	#name : #HOptEliminate,
	#superclass : #HOpt,
	#instVars : [
		'what'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
HOptEliminate class >> eliminate: what [
	^self basicNew 
		what: what;
		yourself
]

{ #category : #'instance creation' }
HOptEliminate class >> new [
	^self eliminate: 'some'
]

{ #category : #construction }
HOptEliminate >> addToQuery: aNNFQuery [ 
	aNNFQuery options eliminate: self
]

{ #category : #logic }
HOptEliminate >> eliminate: q [ 
	what = 'existentials' ifTrue: [ self shouldBeImplemented ].
	what = 'horn' ifTrue: [ ^q elimKVars ].
	^q
]

{ #category : #accessing }
HOptEliminate >> useElim [
	what isNil ifTrue: [ ^false ].
	^what ~= 'none'
]

{ #category : #accessing }
HOptEliminate >> what [
	^ what
]

{ #category : #accessing }
HOptEliminate >> what: anObject [
	what := anObject
]
