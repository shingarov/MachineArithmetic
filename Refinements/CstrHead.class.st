"
If we think of a constraint as a tree, then am a ""goal leaf"".
"
Class {
	#name : #CstrHead,
	#superclass : #HCstr,
	#instVars : [
		'pred'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
CstrHead class >> pred: p [
	^ self basicNew 
		pred: p;
		yourself 
]

{ #category : #logic }
CstrHead >> boundKVars [
	^ self pred pKVars 
]

{ #category : #GT }
CstrHead >> children [ 
	^#()
]

{ #category : #'as yet unclassified' }
CstrHead >> doElim: bss var: k [ 
	(pred isKindOf: RefVarApp) ifTrue: [ 
			pred var = k ifTrue: [ ^CstrHead pred: (HPredAnd of: #()) ]].
	^self
]

{ #category : #logic }
CstrHead >> flatConstraint [
	^CstrHead pred: self pred flatConstraint
]

{ #category : #'as yet unclassified' }
CstrHead >> goS1: kve _: env _: lhs _: be [
	| rhs subc |
	rhs := lhs updSortedReft_kve: kve p: self pred.
	subc := SubC new
		env: env;
		rhs: rhs;
		lhs: lhs;
		yourself.
	^be -> { Either right: subc }
]

{ #category : #'as yet unclassified' }
CstrHead >> goScope: k [ 
	((pred isKindOf: RefVarApp) and: [ pred var = k ]) ifTrue: [ ^Either right: self ].
	^Either left: #l
]

{ #category : #logic }
CstrHead >> isNNF [ 
	^ true
]

{ #category : #'as yet unclassified' }
CstrHead >> isTauto [
	^pred isTauto
]

{ #category : #printing }
CstrHead >> ppOn: aStream indent: n [
	n timesRepeat: [ 	aStream nextPutAll: ' ' ].
	self printMeatOn: aStream

]

{ #category : #accessing }
CstrHead >> pred [
	^ pred
]

{ #category : #accessing }
CstrHead >> pred: anObject [
	pred := anObject
]

{ #category : #printing }
CstrHead >> printMeatOn: aStream [
	aStream nextPut: $(.
	self pred printOn: aStream.
	aStream nextPut: $).

]

{ #category : #'as yet unclassified' }
CstrHead >> pruneTauts [
	^self flatConstraint 
]

{ #category : #'as yet unclassified' }
CstrHead >> rename: a to: b [
	^CstrHead pred: (pred rename: a to: b)
]

{ #category : #'as yet unclassified' }
CstrHead >> sol1: k [
	| k1 ys xs |
	(pred isKindOf: RefVarApp) ifFalse: [ ^#() ].
	k1 := pred var.
	ys := pred args.
	k1 = k ifFalse: [ ^#() ].
	xs := k kArgs: ys.
	^{ #() -> (xs collectWithIndex: [ :x :j | PAtomEq x: x toEVar y: (ys at: j) toEVar ]). }
]

{ #category : #logic }
CstrHead >> uniq1: α [
	^CstrHead pred: (α rename: pred)
]
