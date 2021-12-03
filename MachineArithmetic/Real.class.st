Class {
	#name : #Real,
	#superclass : #Z3ArithmeticNode,
	#category : #'MachineArithmetic-Core'
}

{ #category : #types }
Real class >> sort [
	^ Z3Sort real
]

{ #category : #adapting }
Real >> beLikeMe: value [
	^value toReal
]

{ #category : #testing }
Real >> isReal [
	^true
]

{ #category : #converting }
Real >> toInt [
	^ Z3 mk_real2int: ctx _: self

]

{ #category : #converting }
Real >> toReal [
	^ self

]
