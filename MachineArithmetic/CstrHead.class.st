Class {
	#name : #CstrHead,
	#superclass : #HCstr,
	#instVars : [
		'pred'
	],
	#category : #'MachineArithmetic-Refinement'
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
	^be -> { nil -> subc. }
]

{ #category : #logic }
CstrHead >> isNNF [ 
	^ true
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
