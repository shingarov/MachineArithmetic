Class {
	#name : #EdgeRank,
	#superclass : #Dictionary,
	#category : #Refinements
}

{ #category : #'instance creation' }
EdgeRank class >> from: es [
"
edgeRank :: [CEdge] -> EdgeRank
"
	| KCs kiM C_s n |
	es isEmpty ifTrue: [ ^self new ].
	KCs := es select: [ :kc | kc key isKVar and: [ kc value isCstr ] ].
	kiM := (KCs collect: [ :kc | kc key kvar -> kc value id ]) groupAssociations.
	C_s := es select: [ :kc | kc key isCstr ].
	n := (C_s collect: [ :c_ | c_ key id ]) 
		ifEmpty: [^nil]
		ifNotEmpty: [ :ids | ids max + 1 ].
	^(kiM collect: [ :aSet | aSet min min: n ]) as: self
]

{ #category : #'as yet unclassified' }
EdgeRank >> edgeRankCut [
"
edgeRankCut :: EdgeRank -> Cutter CVertex
type Cutter a = [(a, a, [a])] -> Maybe (a, [(a, a, [a])])
"
	^[ :vs | self edgeRankCut: vs ]
]

{ #category : #'as yet unclassified' }
EdgeRank >> edgeRankCut: vs [
"
edgeRankCut :: EdgeRank -> Cutter CVertex
type Cutter a = [(a, a, [a])] -> Maybe (a, [(a, a, [a])])
Here is a fun example of currying.
In Smalltalk, this method when bound to self, *is* the Cutter.
"
	| ks k |
	ks := vs select: [ :v | v first isKVar ] thenCollect: [ :k__ | k__ first ].
	ks := ks sorted: [ :a :b | (self at: a kvar) <= (self at: b kvar) ].
	ks isEmpty ifTrue: [ ^nil ].
	k := ks first.
	
	^k -> (vs select: [ :u__ | u__ first ~= k ])
]
