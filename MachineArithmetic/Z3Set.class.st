Class {
	#name : #Z3Set,
	#superclass : #McCarthyArray,
	#category : #'MachineArithmetic-Core'
}

{ #category : #Monoid }
Z3Set class >> emptyOf: elementSort [
	^ Z3 mk_empty_set: elementSort ctx _: elementSort
]

{ #category : #Monoid }
Z3Set class >> fullOf: elementSort [
	^ Z3 mk_full_set: elementSort ctx _: elementSort
]

{ #category : #'finite instance creation' }
Z3Set class >> with: anElement [
	| set |
	set := self emptyOf: anElement sort.
	^set add: anElement
]

{ #category : #'set theory' }
Z3Set >> \ anotherSet [
	^ self difference: anotherSet
]

{ #category : #'set theory' }
Z3Set >> add: element [
	"Assume the receiver is a set.
	 Non-destructively add element to the receiver."
	^Z3 mk_set_add: ctx _: self _: (self sort domain cast: element)
	"domain cast: takes care of both making sure element is of the right sort,
	 and coercing those that can be coerced"
]

{ #category : #'set theory' }
Z3Set >> complement [
	^Z3 mk_set_complement: self ctx _: self
]

{ #category : #'set theory' }
Z3Set >> difference: anotherSet [
	"Take the set difference between two sets."
	anotherSet ensureSet.
	^Z3 mk_set_difference: ctx _: self _: anotherSet
]

{ #category : #utilities }
Z3Set >> ensureSet [
	"No-op - an instance of Z3Set is indeed a set"
]

{ #category : #'set theory' }
Z3Set >> includes: element [
	"Assume the receiver is a set.
	 Answer the Z3 Bool formula for set membership."
	^Z3 mk_set_member: ctx _: (self sort domain cast: element) _: self
]

{ #category : #'set theory' }
Z3Set >> intersection: anotherSet [
	anotherSet ensureSet.
	
	^Z3 mk_set_intersect: ctx _: 2 _: { self . anotherSet }
]

{ #category : #'set theory' }
Z3Set >> isEmptySet [
	^self === (Z3Set emptyOf: self sort domain)
]

{ #category : #'set theory' }
Z3Set >> isSubsetOf: anotherSet [
	"Check for subsetness of sets."
	anotherSet ensureSet.
	^Z3 mk_set_subset: ctx _: self _: anotherSet
]

{ #category : #'set theory' }
Z3Set >> remove: oldElement [
	"Assume the receiver is a set.
	 Non-destructively remove element from the receiver."
	^Z3 mk_set_del: self ctx _: self _: (self sort domain cast: oldElement)
]

{ #category : #'set theory' }
Z3Set >> union: anotherSet [
	anotherSet ensureSet.
	
	^Z3 mk_set_union: ctx _: 2 _: { self . anotherSet }
]

{ #category : #'set theory' }
Z3Set >> without: anElement [
	^self \ (self sort domain cast: anElement) toSingletonZ3Set
]
