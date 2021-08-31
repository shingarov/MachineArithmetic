Class {
	#name : #Z3ArithmeticNode,
	#superclass : #Z3Node,
	#category : #'MachineArithmetic-Core'
}

{ #category : #arithmetic }
Z3ArithmeticNode class >> max: aCollectionOfInts [
	aCollectionOfInts isEmpty ifTrue: [ ^self error ].
	aCollectionOfInts size=1 ifTrue: [ ^aCollectionOfInts first ].
	^aCollectionOfInts first max: (self max: aCollectionOfInts allButFirst)
]

{ #category : #arithmetic }
Z3ArithmeticNode class >> min: aCollectionOfInts [
	aCollectionOfInts isEmpty ifTrue: [ ^self error ].
	aCollectionOfInts size=1 ifTrue: [ ^aCollectionOfInts first ].
	^aCollectionOfInts first min: (self min: aCollectionOfInts allButFirst)
]

{ #category : #arithmetic }
Z3ArithmeticNode >> * rhs [
	^ Z3 mk_mul: ctx _: 2 _: { self . (self coerce: rhs) }.

]

{ #category : #arithmetic }
Z3ArithmeticNode >> + rhs [
	^ Z3 mk_add: ctx _: 2 _: { self . (self coerce: rhs) }.

]

{ #category : #arithmetic }
Z3ArithmeticNode >> - rhs [
	^ Z3 mk_sub: ctx _: 2 _: { self . (self coerce: rhs) }

]

{ #category : #arithmetic }
Z3ArithmeticNode >> / rhs [
	^ Z3 mk_div: ctx _: self _: (self coerce: rhs).

]

{ #category : #comparing }
Z3ArithmeticNode >> < rhs [
	^ Z3 mk_lt: ctx _: self _: (self coerce: rhs).

]

{ #category : #comparing }
Z3ArithmeticNode >> <= rhs [
	^ Z3 mk_le: ctx _: self _: (self coerce: rhs).

]

{ #category : #comparing }
Z3ArithmeticNode >> > rhs [
	^ Z3 mk_gt: ctx _: self _: (self coerce: rhs).

]

{ #category : #comparing }
Z3ArithmeticNode >> >= rhs [
	^ Z3 mk_ge: ctx _: self _: (self coerce: rhs).

]

{ #category : #arithmetic }
Z3ArithmeticNode >> abs [
	^ self >= 0 ifThen: self else: self negated

]

{ #category : #arithmetic }
Z3ArithmeticNode >> max: rhs [ 
	^self <= rhs ifThen: rhs else: self
]

{ #category : #arithmetic }
Z3ArithmeticNode >> min: rhs [ 
	^self <= rhs ifThen: self else: rhs
]

{ #category : #arithmetic }
Z3ArithmeticNode >> negated [
	^ Z3 mk_unary_minus: ctx _: self

]
