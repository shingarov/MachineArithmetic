Class {
	#name : #HCstr,
	#superclass : #HThing,
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
HCstr class >> body: b [
	^self basicNew
		body: b
]

{ #category : #logic }
HCstr >> addToQuery: aNNFQuery [ 
	aNNFQuery qCstr add: self
]

{ #category : #logic }
HCstr >> boundKVars [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
HCstr >> demorgan: x t: t kvars: kvars preds: preds bss: bss [
	| su cubeSols |
	su := Dictionary newFromAssociations: (kvars collectAndCat: [ :k_xs |
			| k xs |
			k := k_xs key.
			xs := k_xs value.
			xs collectWithIndex: [ :arg :j | (k κ: j) -> arg "the Expr" ]] ) .
	cubeSols := bss collect: [ :ass | ass cubeSolIfEmpty: [
			| eqs newEqs newPreds |
			eqs := ass value.
			newEqs := eqs collect: [ :eq | eq subst: su ].
			newPreds := preds collect: [ :pr | pr shouldBeImplemented ].
			CstrAll
				bind: (HBind x: x τ: t p: (HPredAnd of: newEqs, newPreds))
				p: self ] ].
	^CstrAnd of: cubeSols
]

{ #category : #'as yet unclassified' }
HCstr >> elim [
	| res |
	res := self boundKVars inject: self into: [ :c :k | c elim1: k ].
	res boundKVars isEmpty ifFalse: [ self error: '' ].
	^res
]

{ #category : #'as yet unclassified' }
HCstr >> elim1: k [
	"Find a `sol1` solution to a kvar `k`, and then subsitute in the solution for each rhs occurrence of k."
	| scope sol |
	scope := self scope: k.
	sol := scope sol1: k.
	^(self doElim: sol var: k) simplify
]

{ #category : #logic }
HCstr >> flatConstraint [
	"Removes redundant `and`s and empty conjuncts."
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
HCstr >> goS1: aCollection _: anIBindEnv _: aSortedReft _: aBindEnv [ 
	self subclassResponsibility 
]

{ #category : #GT }
HCstr >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 50>
	^ composite fastTree
		title: 'Tree';
		children: #children;
		display: [ Array with: self ]
]

{ #category : #logic }
HCstr >> isNNF [
	"Answer whether the constraint does not contain any existential binders."
	self 
]

{ #category : #printing }
HCstr >> printMeatOn: aStream [
	self subclassResponsibility 
]

{ #category : #printing }
HCstr >> printOn: aStream [
	aStream nextPutAll: 'constraint( '.
	self printMeatOn: aStream.
	aStream nextPutAll: ' )'.
]

{ #category : #'as yet unclassified' }
HCstr >> pruneTauts [
	self subclassResponsibility
]

{ #category : #'term rewriting' }
HCstr >> rename: a to: b renamer: α [ 
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
HCstr >> scope: k [
 (self goScope: k)
		left: [ :l | ^CstrHead pred: Reft shouldBeImplemented ]
		right: [ :c | ^c ]
]

{ #category : #logic }
HCstr >> simplify [
	"Cleanup Horn constraint.
	We want to simplify the Query a little bit, and make sure it is Horn,
	that is, only a kvar-free (ie concrete) predicate or a single kvar in each head."
	^ self flatConstraint pruneTauts "removeDuplicateBinders" "BOGUS"
]

{ #category : #logic }
HCstr >> uniq [
	"Make sure each binder has a unique name."
	^self uniq1: AlphaRenamer new
]

{ #category : #logic }
HCstr >> uniq1: anAlphaRenamer [ 
	self subclassResponsibility 
]

{ #category : #logic }
HCstr >> ↑ [ κ
	"Answer the uses of κ in the receiver."
	self shouldBeImplemented 
]

{ #category : #logic }
HCstr >> ↓ [ κ
	"Answer the definitions of κ in the receiver."
	self shouldBeImplemented 
]
