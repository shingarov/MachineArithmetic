Class {
	#name : #McCarthyArray,
	#superclass : #Z3Node,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
McCarthyArray class >> name: aString domain: d range: r [
	^ d-->r mkConst: aString
]

{ #category : #'set theory' }
McCarthyArray >> add: element [
	"Assume the receiver is a set.
	 Non-destructively add element to the receiver."
	self ensureSet.
	^Z3 mk_set_add: ctx _: self _: (self sort domain cast: element)
	"domain cast: takes care of both making sure element is of the right sort,
	 and coercing those that can be coerced"
]

{ #category : #enumerating }
McCarthyArray >> arraySelect: i [
	^ Z3 mk_select: ctx _: self _: i

]

{ #category : #enumerating }
McCarthyArray >> arrayStore: i put: v [
	^ Z3 mk_store: ctx _: self _: i _: v

]

{ #category : #'set theory' }
McCarthyArray >> canBeSet [
	^self sort range == Z3Sort bool
]

{ #category : #'set theory' }
McCarthyArray >> complement [
	^Z3 mk_set_complement: self ctx _: self
]

{ #category : #'set theory' }
McCarthyArray >> ensureSet [
	self canBeSet ifFalse: [ self error ]
]

{ #category : #'set theory' }
McCarthyArray >> includes: element [
	"Assume the receiver is a set.
	 Answer the Z3 Bool formula for set membership."
	self ensureSet.
	^Z3 mk_set_member: ctx _: (self sort domain cast: element) _: self
]

{ #category : #'set theory' }
McCarthyArray >> remove: oldElement [
	"Assume the receiver is a set.
	 Non-destructively remove element from the receiver."
	self ensureSet.
	^Z3 mk_set_del: self ctx _: self _: (self sort domain cast: oldElement)
]
