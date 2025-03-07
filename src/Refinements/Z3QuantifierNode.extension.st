Extension { #name : #Z3QuantifierNode }

{ #category : #'*Refinements' }
Z3QuantifierNode >> isPAll [
	^self isForAll
]

{ #category : #'*Refinements' }
Z3QuantifierNode >> isPExist [
	"Answer whether Fixpoint would consider this node a PExist."
	^self isExists
]
