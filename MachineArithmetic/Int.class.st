Class {
	#name : #Int,
	#superclass : #AST,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Int class >> const: nameString [
	^AST mkConst: (Z3Symbol from: nameString) ofSort: Z3Sort int
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
	^(LibZ3 uniqueInstance mkLt: ctx t1: self t2: rhs )
		ctx: ctx
]

{ #category : #arithmetic }
Int >> <= rhs [
	^(LibZ3 uniqueInstance mkLe: ctx t1: self t2: rhs toInt )
		ctx: ctx
]

{ #category : #arithmetic }
Int >> > rhs [
	^(LibZ3 uniqueInstance mkGt: ctx t1: self t2: rhs )
		ctx: ctx
]

{ #category : #arithmetic }
Int >> >= rhs [
	^(LibZ3 uniqueInstance mkGe: ctx t1: self t2: rhs toInt )
		ctx: ctx
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
Int >> toInt [
	^self
]
