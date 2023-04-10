"
I am a brain-damaged function Sort which is not a Z3Sort.
"
Class {
	#name : #FFunc,
	#superclass : #PreSort,
	#instVars : [
		'from',
		'to'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FFunc class >> from: dom to: cod [
	^self basicNew
		from: dom;
		to: cod;
		yourself
]

{ #category : #comparing }
FFunc >> = rhs [
	self class = rhs class ifFalse: [ ^false ].
	^from = rhs from and: [ to = rhs to ]
]

{ #category : #'as yet unclassified' }
FFunc >> checkFunSort [
	^{ from . to . TVSubst new }
]

{ #category : #accessing }
FFunc >> from [
	^ from
]

{ #category : #accessing }
FFunc >> from: anObject [
	from := anObject
]

{ #category : #'as yet unclassified' }
FFunc >> goMapSort: stepBlock [
"cf. Visitor.hs"
	^FFunc from: (stepBlock value: from) to: (stepBlock value: to) 
]

{ #category : #'as yet unclassified' }
FFunc >> guest [
	^self
]

{ #category : #comparing }
FFunc >> hash [
	^from hash
]

{ #category : #printing }
FFunc >> printOn: aStream [
	aStream nextPut: $(.
	from printOn: aStream.
	aStream nextPut: (Character codePoint: 16r2192).
	to printOn: aStream.
	aStream nextPut: $).
	
]

{ #category : #'SMT interface' }
FFunc >> smt2var: v in: γ [
	| z3from z3to |
	z3from := from z3sort.
	γ sort note: from elaboratedTo: z3from. "do we need this anymore??"
	z3to := to z3sort.
	γ sort note: to elaboratedTo: z3to. "same: do we need this anymore??"
	^v functionFrom: {z3from} to: z3to "oooh, this is going to be difficult when we implement uncurry"
]

{ #category : #'as yet unclassified' }
FFunc >> sortSubst: θ [
"
sortSubst θ (FFunc t1 t2) = FFunc (sortSubst θ t1) (sortSubst θ t2)
"
	^θ at: self ifAbsent: [ 
		FFunc
			from: (from sortSubst: θ)
			to: (to sortSubst: θ)
	]
]

{ #category : #'as yet unclassified' }
FFunc >> subst: j _: tj [
	| t1_ t2_ |
	t1_ := from subst: j _: tj.
	t2_ := to   subst: j _: tj.
	^FFunc from: t1_ to: t2_
]

{ #category : #accessing }
FFunc >> to [
	^ to
]

{ #category : #accessing }
FFunc >> to: anObject [
	to := anObject
]

{ #category : #'as yet unclassified' }
FFunc >> z3sort [
	^from z3sort ==> to z3sort
]
