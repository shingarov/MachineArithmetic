Class {
	#name : #Z3ArithmeticNode,
	#superclass : #Z3Node,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Z3ArithmeticNode class >> const: nameString [
	^self mkConst: (Z3Symbol from: nameString) ofSort: self sort
]

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

{ #category : #types }
Z3ArithmeticNode class >> sort [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
Z3ArithmeticNode class >> value: x [
	^self sort numeralFrom: x asString
]

{ #category : #'instance creation' }
Z3ArithmeticNode class >> var: name [
	^ Z3Context current mkVar: name ofSort: self sort
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
Z3ArithmeticNode >> \\ rhs [
	^ Z3 mk_mod: ctx _: self _: (self coerce: rhs).

]

{ #category : #arithmetic }
Z3ArithmeticNode >> abs [
	^ self >= 0 ifThen: self else: self negated

]

{ #category : #testing }
Z3ArithmeticNode >> even [
	"Refer to the comment in Number|even."
	^self \\ 2 === 0
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

{ #category : #testing }
Z3ArithmeticNode >> odd [
	"Refer to the comment in Number|odd."
	^self even not
]
