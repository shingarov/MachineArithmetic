Class {
	#name : #Int,
	#superclass : #Z3ArithmeticNode,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Int class >> const: nameString [
	^self mkConst: (Z3Symbol from: nameString) ofSort: self sort
]

{ #category : #'instance creation' }
Int class >> create: n constantsPrefix: x [
	"Create an array of n Int constants: x__1, x__2,... x__n"
	^(1 to: n) collect: [ :i |
		Int const: x, '__', i printString ]
]

{ #category : #sorting }
Int class >> sort [
	^Z3Sort int
]

{ #category : #'instance creation' }
Int class >> value: x [
	^Int sort numeralFrom: x asString
]

{ #category : #'instance creation' }
Int class >> var: variableName [
	"Create an Int variable of the given name.
	The argument variableName here can be a String or an Integer."
	^Z3Context current mkIntVar: variableName
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
