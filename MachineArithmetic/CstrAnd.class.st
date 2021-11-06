Class {
	#name : #CstrAnd,
	#superclass : #HCstr,
	#instVars : [
		'conjuncts'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
CstrAnd class >> of: conjuncts [
	^self basicNew
		conjuncts: conjuncts;
		yourself
]

{ #category : #logic }
CstrAnd >> boundKVars [
	| answer |
	answer := Set new.
	(self conjuncts collect: [ :child | child boundKVars ]) do: [ :aSet | answer addAll: aSet ].
	^answer
]

{ #category : #accessing }
CstrAnd >> conjuncts [
	^ conjuncts
]

{ #category : #accessing }
CstrAnd >> conjuncts: anObject [
	conjuncts := anObject
]

{ #category : #logic }
CstrAnd >> flatConstraint [
	| flatConjuncts |
	flatConjuncts := self conjuncts flatConstraint.
	"special-case of singleton collection"
	flatConjuncts size = 1 ifTrue: [ ^flatConjuncts anyOne ].
	^CstrAnd of: flatConjuncts
]

{ #category : #'as yet unclassified' }
CstrAnd >> goS1: kve _: env _: whatwhat _: be [

self shouldBeImplemented 
]

{ #category : #logic }
CstrAnd >> isNNF [ 
	^ self conjuncts allSatisfy: [ :conjunct | conjunct isNNF ]
]

{ #category : #printing }
CstrAnd >> printMeatOn: aStream [
	aStream nextPutAll: '(and'.
	self conjuncts do: [ :c1 |
		aStream nextPut: $ .
		c1 printOn: aStream ].
	aStream nextPutAll: ')'
]
