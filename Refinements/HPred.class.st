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
	#category : #Refinements
}

{ #category : #comparing }
HPred >> = another [
	self subclassResponsibility
]

{ #category : #GT }
HPred >> children [
	^#()
]

{ #category : #'as yet unclassified' }
HPred >> conjuncts [
	^{self}
]

{ #category : #'term rewriting' }
HPred >> evaluateIn: aBindEnv [ 
	self subclassResponsibility
]

{ #category : #logic }
HPred >> findKVarInGuard: k [ 
	^Either right: self
]

{ #category : #logic }
HPred >> flatConstraint [
	^self
]

{ #category : #comparing }
HPred >> hash [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
HPred >> isConc [
	"note: this should be combined with PKVar>>isConc"
	^self kvarsExpr isEmpty
]

{ #category : #'as yet unclassified' }
HPred >> isTautoPred [
	"BOGUS"
	^false
]

{ #category : #'as yet unclassified' }
HPred >> kvarsExpr [
	"BOGUS.  For now let's assume only literally RefVarApps have kappas."
	^#()
]

{ #category : #'as yet unclassified' }
HPred >> mapKVarSubsts: twoArgumentBlock [ 
	^self "?"
]

{ #category : #logic }
HPred >> pKVars [
	^ Set new
]

{ #category : #logic }
HPred >> predExpr: kvEnv [ 
	^self 
]

{ #category : #'term rewriting' }
HPred >> rename: a to: b [
	self subclassResponsibility 
]

{ #category : #'term rewriting' }
HPred >> subst1: new for: old [
	^DelayedSubst from: old toExpr: new in: self
]

{ #category : #'term rewriting' }
HPred >> subst: aDictionary [
	^self subclassResponsibility 
]

{ #category : #'well-formedness' }
HPred >> wfIn: gamma [ 
self shouldBeImplemented
]
