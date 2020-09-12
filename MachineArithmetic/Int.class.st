Class {
	#name : #Int,
	#superclass : #AST,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Int class >> const: nameString [
	^AST mkConst: (Z3Symbol from: nameString) ofSort: Z3Sort int
]

{ #category : #'instance creation' }
Int class >> create: n constantsPrefix: x [
	"Create an array of n Int constants: x__1, x__2,... x__n"
	^(1 to: n) collect: [ :i |
		Int const: x, '__', i printString ]
]

{ #category : #printing }
Int class >> printSort: ty on: aStream [
	aStream nextPutAll: 'int'
]

{ #category : #'instance creation' }
Int class >> var: variableName [
	^Z3Context current mkIntVar: variableName
]

{ #category : #arithmetic }
Int >> * rhs [
	| args |
	args := self mkExternalArray: { self . (self coerce: rhs) }.
	^(LibZ3 uniqueInstance mkMul: ctx numArgs: 2 args: args)
		ctx: ctx
]

{ #category : #arithmetic }
Int >> + rhs [
	| args |
	args := self mkExternalArray: { self . (self coerce: rhs) }.
	^(LibZ3 uniqueInstance mkAdd: ctx numArgs: 2 args: args)
		ctx: ctx
]

{ #category : #arithmetic }
Int >> - rhs [
	| args |
	args := self mkExternalArray: { self . (self coerce: rhs) }.
	^(LibZ3 uniqueInstance mkSub: ctx numArgs: 2 args: args)
		ctx: ctx
]

{ #category : #arithmetic }
Int >> / divisor [
	^(LibZ3 uniqueInstance mkDiv: ctx dividend: self divisor: divisor )
		ctx: ctx
]

{ #category : #arithmetic }
Int >> < rhs [
	^(LibZ3 uniqueInstance mkLt: ctx t1: self t2: (self coerce: rhs))
		ctx: ctx
]

{ #category : #arithmetic }
Int >> <= rhs [
	^(LibZ3 uniqueInstance mkLe: ctx t1: self t2: rhs toInt )
		ctx: ctx
]

{ #category : #arithmetic }
Int >> > rhs [
	^(LibZ3 uniqueInstance mkGt: ctx t1: self t2: (self coerce: rhs) )
		ctx: ctx
]

{ #category : #arithmetic }
Int >> >= rhs [
	^AST
		wrap: (LibZ3 uniqueInstance mkGe: ctx t1: self t2: rhs toInt )
		in: ctx
]

{ #category : #arithmetic }
Int >> abs [
	^self >= 0
		ifThen: self
		else: self negated
		
]

{ #category : #adapting }
Int >> beLikeMe: value [
	^value toInt
]

{ #category : #arithmetic }
Int >> isInt [
	^true
]

{ #category : #arithmetic }
Int >> negated [
	^AST
		wrap: (LibZ3 uniqueInstance mkUnaryMinus: ctx arg: self)
		in: ctx
]

{ #category : #arithmetic }
Int >> toInt [
	^self
]
