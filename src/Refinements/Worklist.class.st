Class {
	#name : #Worklist,
	#superclass : #Object,
	#instVars : [
		'cs',
		'pend',
		'deps',
		'cm',
		'rankm',
		'last',
		'ranks',
		'time',
		'concCs'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Worklist class >> new [
	self shouldNotImplement
]

{ #category : #utils }
Worklist class >> workItemsAt: rDict _: t _: i [
	^WorkItem cId: i time: t rank: (rDict at: i)
]

{ #category : #accessing }
Worklist >> cm [
	^ cm
]

{ #category : #accessing }
Worklist >> cm: anObject [
	cm := anObject
]

{ #category : #'as yet unclassified' }
Worklist >> compileIn: aBindEnv [ 
	cm := cm collect: [ :c | c compileIn: aBindEnv ]
]

{ #category : #accessing }
Worklist >> concCs [
	^ concCs
]

{ #category : #accessing }
Worklist >> concCs: anObject [
	concCs := anObject
]

{ #category : #accessing }
Worklist >> cs [
	^ cs
]

{ #category : #accessing }
Worklist >> cs: anObject [
	cs := anObject
]

{ #category : #accessing }
Worklist >> deps [
	^ deps
]

{ #category : #accessing }
Worklist >> deps: anObject [
	deps := anObject
]

{ #category : #'private - initialization' }
Worklist >> initializeFrom: sI [
	"Initialize worklist and slice out irrelevant constraints.
	cf. Worklist.hs"
	| cd kvarCs items |
	cm := sI query cm.
	cd := sI deps.
	rankm := cd rank.
	kvarCs := (cm reject: #isTarget) keys.
	concCs := (cm select: #isTarget) keys.
	items := kvarCs collect: [ :eachKvarC | self class workItemsAt: rankm _: 0 _: eachKvarC ].
	cs := WorkSet withAll: items.
	pend := PendingMap newFromKeys: kvarCs andValues: (Array new: kvarCs size).
	deps := cd succ.
	last := nil.
	ranks := cd numScc.
	time := 0.
]

{ #category : #accessing }
Worklist >> last [
	^ last
]

{ #category : #accessing }
Worklist >> last: anObject [
	last := anObject
]

{ #category : #'as yet unclassified' }
Worklist >> newSCC: i [
	| newRank oldRank |
	newRank := rankm at: i.
	oldRank := last isNil
		ifTrue: [ nil ]
		ifFalse: [ rankm at: last ].
	newRank := newRank isNil ifTrue: [ nil ] ifFalse: [ newRank scc ].
	oldRank := oldRank isNil ifTrue: [ nil ] ifFalse: [ oldRank scc ].
	^newRank ~= oldRank
]

{ #category : #accessing }
Worklist >> pend [
	^ pend
]

{ #category : #accessing }
Worklist >> pend: anObject [
	pend := anObject
]

{ #category : #'stack-compliant protocol' }
Worklist >> pop [
"pop  :: Worklist a -> Maybe (F.SimpC a, Worklist a, Bool, Int)
cf. Worklist.hs"
	| i_is i is |
	i_is := cs sPop.
	i_is isNil ifTrue: [ ^nil ].
	i := i_is key.
	is := i_is value.
	^{
	cm at: i.
	self popW: i workSet: is.
	self newSCC: i.
	self rank: i
	}
]

{ #category : #'stack-compliant protocol' }
Worklist >> popW: i workSet: is [ 
	^self copy
		cs: is;
		last: i;
		pend: (pend copy removeKey: i; yourself);
		yourself 
]

{ #category : #'stack-compliant protocol' }
Worklist >> push: c [
	"Add a constraint and all its dependencies.
	push :: F.SimpC a -> Worklist a -> Worklist a"
	| i is′ wis′ t wp wcs′ |
	wp := pend.
	t := time.
	i := c id.
	is′ := (deps at: i ifAbsent: #()) reject: [ :dep | wp includesKey: dep ].
	wis′ := is′ collect: [ :eachI | WorkItem at: eachI map: rankm time: time ].
	wcs′ := cs sAdds: wis′.
	^self copy
		cs: wcs′;
		time: t + 1;
		pend: (wp addPends: is′);
		yourself
]

{ #category : #'as yet unclassified' }
Worklist >> rank: i [
"rank :: Worklist a -> F.SubcId -> Int"
	^(rankm at: i) scc
]

{ #category : #accessing }
Worklist >> rankm [
	^ rankm
]

{ #category : #accessing }
Worklist >> rankm: anObject [
	rankm := anObject
]

{ #category : #accessing }
Worklist >> ranks [
	^ ranks
]

{ #category : #accessing }
Worklist >> ranks: anObject [
	ranks := anObject
]

{ #category : #accessing }
Worklist >> time [
	^ time
]

{ #category : #accessing }
Worklist >> time: anObject [
	time := anObject
]

{ #category : #logic }
Worklist >> unsatCandidates [
	"Candidate Constraints to be checked AFTER computing Fixpoint.
	Answer a collection of SimpC's"	
	^concCs collect: [ :i | cm at: i ]
]
