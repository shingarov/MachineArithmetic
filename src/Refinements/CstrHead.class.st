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
CstrHead >> flatten [
	^self pred flatten cHead
]

{ #category : #'as yet unclassified' }
CstrHead >> goScope: k [ 
	((pred isKindOf: RefVarApp) and: [ pred var = k ]) ifTrue: [ ^Either right: self ].
	^Either left: #l
]

{ #category : #'as yet unclassified' }
CstrHead >> goS′: kve _: env _: lhs _: be [
	| rhs subc |
	rhs := lhs updSortedReft_kve: kve p: self pred.
	subc := SubC mkSubC: env lhs: lhs rhs: rhs i: nil tag: #().
	^be -> { Either right: subc }
]

{ #category : #logic }
CstrHead >> isNNF [ 
	^ true
]

{ #category : #printing }
CstrHead >> ppOn: aStream indent: n [
	n timesRepeat: [ 	aStream nextPutAll: ' ' ].
	self printOn: aStream

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
CstrHead >> printOn: aStream [
	aStream nextPut: 16r2388 asCharacter.
	self pred printOn: aStream
]

{ #category : #'as yet unclassified' }
CstrHead >> pruneTauts [
	^self flatten 
]

{ #category : #'as yet unclassified' }
CstrHead >> pruneTautsGo [
"
go (Head p l) = do
  p' <- goP p
  pure $ Head p' l
"
	| p_ |
	p_ := pred pruneTautsGoP.
	^CstrHead pred: p_
]

{ #category : #'α-renaming' }
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
	^{ #() -> (xs collectWithIndex: [ :x :j | PAtom brel: #=== x: x toEVar y: (ys at: j) toEVar ]). }
]

{ #category : #logic }
CstrHead >> uniq1: α [
	^CstrHead pred: (α rename: pred)
]
