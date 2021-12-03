Class {
	#name : #Int,
	#superclass : #Z3ArithmeticNode,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Int class >> create: n constantsPrefix: x [
	"Create an array of n Int constants: x__1, x__2,... x__n"
	^(1 to: n) collect: [ :i |
		Int const: x, '__', i printString ]
]

{ #category : #types }
Int class >> sort [
	^Z3Sort int
]

{ #category : #adapting }
Int >> beLikeMe: value [
	^value toInt
]

{ #category : #testing }
Int >> isInt [
	^true
]

{ #category : #converting }
Int >> toBitVector: size [
	^ Z3 mk_int2bv: ctx _: size _: self

]

{ #category : #converting }
Int >> toInt [
	^self
]

{ #category : #converting }
Int >> toReal [
	^ Z3 mk_int2real: ctx _: self

]
