"
Constraint Dependencies

IVars:
cSucc   :: !(F.CMap [F.SubcId]) -- ^ Constraints *written by* a SubcId
cPrev   :: !(F.CMap [F.KVar])   -- ^ (Cut) KVars *read by*    a SubcId
cRank   :: !(F.CMap Rank)       -- ^ SCC rank of a SubcId
cNumScc :: !Int                 -- ^ Total number of Sccs

"
Class {
	#name : #CDeps,
	#superclass : #Object,
	#instVars : [
		'succ',
		'prev',
		'rank',
		'numScc'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
CDeps class >> new [
	self shouldNotImplement 
]

{ #category : #'instance creation' }
CDeps class >> succ: succ prev: prev rank: rank numScc: numScc [
	^self basicNew succ: succ; prev: prev; rank: rank; numScc: numScc; yourself 
]

{ #category : #accessing }
CDeps >> numScc [
	^ numScc
]

{ #category : #accessing }
CDeps >> numScc: anObject [
	numScc := anObject
]

{ #category : #accessing }
CDeps >> prev [
	^ prev
]

{ #category : #accessing }
CDeps >> prev: anObject [
	prev := anObject
]

{ #category : #accessing }
CDeps >> rank [
	^ rank
]

{ #category : #accessing }
CDeps >> rank: anObject [
	rank := anObject
]

{ #category : #accessing }
CDeps >> succ [
	^ succ
]

{ #category : #accessing }
CDeps >> succ: anObject [
	succ := anObject
]
