Class {
	#name : #Z3ArithmeticNode,
	#superclass : #Z3Node,
	#category : #'MachineArithmetic-Core'
}

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
Z3ArithmeticNode >> negated [
	^ Z3 mk_unary_minus: ctx _: self

]
