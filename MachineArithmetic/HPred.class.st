"
A Horn predicate that appears as LHS (body) or RHS (head) of constraints.

This can either be
- a refinement from a decidable logic: r; or
- a refinement variable application: kappa(arg1,...); or
- a conjunction of sub-predicates.
"
Class {
	#name : #HPred,
	#superclass : #Object,
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #logic }
HPred >> flatConstraint [
	^self
]

{ #category : #logic }
HPred >> pKVars [
	^ Set new
]

{ #category : #'as yet unclassified' }
HPred >> predExpr: kvEnv [ 
	self subclassResponsibility 
]

{ #category : #'well-formedness' }
HPred >> wfIn: gamma [ 
self shouldBeImplemented
]
