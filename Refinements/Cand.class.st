"
A Solution Candidate is an association list indexed by predicates
  type Cand a   = [(Expr, a)]
cf. Types/Solutions.hs

"
Class {
	#name : #Cand,
	#superclass : #Object,
	#instVars : [
		'list'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
Cand class >> list: l [ 
	^self basicNew list: l; yourself 
]

{ #category : #'as yet unclassified' }
Cand >> filterValid: p [
"cf. Monad.hs
Here qs = self, and we are ignoring SrcSpan for now.
The receiver's list is of the form [(q1,x1),...(qn,xn)];
answer the list of only those [ xi | p => qi ].
" 
	
	^list select: [ :q_x |
		| q |
		q := q_x key.
		Z3Solver isValid: p==>q ]
	thenCollect: [ :q_x |
		q_x value ]
]

{ #category : #accessing }
Cand >> list [
	^ list
]

{ #category : #accessing }
Cand >> list: anObject [
	list := anObject
]
