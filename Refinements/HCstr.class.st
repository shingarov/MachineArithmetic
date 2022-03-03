Class {
	#name : #HCstr,
	#superclass : #HThing,
	#category : #Refinements
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
	| suki su cubeSols |
	"first compute the Subst; bss isn't needed for this"
	suki := kvars collectAndCat: [ :k_xs |
			| k xs |
			k := k_xs key.
			xs := k_xs value.
			k oneSuka: xs ] .
	su := Subst mkSubst: suki.
	cubeSols := bss collect: [ :ass | ass cubeSol_x: x t: t su: su preds: preds c: self ].
	^CstrAnd of: cubeSols
]

{ #category : #'as yet unclassified' }
HCstr >> elim [
	| res |
	res := self boundKVars inject: self into: [ :c :k | c elim1: k ].
	res boundKVars isEmpty ifFalse: [ self error: 'called elim on cyclic constraint' ].
	^res
]

{ #category : #'as yet unclassified' }
HCstr >> elim1: k [
	"Find a `sol1` solution to a kvar `k`, and then subsitute in the solution for each rhs occurrence of k.
	cf. Horn/Transformations.hs"
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
	"goS' :: KVEnv a -> F.IBindEnv -> F.SortedReft -> F.BindEnv -> H.Cstr a
    -> (F.BindEnv, [Either F.BindId (F.SubC a)])
	cf. various forms of goS' in Horn/Info.hs"
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
	"Make sure each binder has a unique name.
	 cf. Horn/Transformations.hs"
	^self uniq1: AlphaRenamer new
]

{ #category : #logic }
HCstr >> uniq1: anAlphaRenamer [ 
	self subclassResponsibility 
]
