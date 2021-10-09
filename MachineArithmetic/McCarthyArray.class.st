Class {
	#name : #McCarthyArray,
	#superclass : #Z3Node,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
McCarthyArray class >> emptySetOf: aSort [
	^Z3 mk_empty_set: aSort ctx _: aSort
]

{ #category : #'instance creation' }
McCarthyArray class >> fullSetOf: aSort [
	^Z3 mk_full_set: aSort ctx _: aSort
]

{ #category : #'instance creation' }
McCarthyArray class >> name: aString domain: d range: r [
	^ d-->r mkConst: aString
]

{ #category : #'set theory' }
McCarthyArray >> add: element [
		^Z3 mk_set_add: self ctx _: self _: (self sort domain number: element)
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
McCarthyArray >> includes: element [ 
	^Z3 mk_set_member: self ctx _: (self sort domain number: element) _: self
]

{ #category : #'set theory' }
McCarthyArray >> remove: oldElement [ 
	^Z3 mk_set_del: self ctx _: self _: (self sort domain number: oldElement)
]
