Class {
	#name : #Z3ParameterSet,
	#superclass : #Z3ContextedObject,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Z3ParameterSet class >> on: aZ3Context [
	^(LibZ3 uniqueInstance mkParams: aZ3Context)
		ctx: aZ3Context;
		yourself 
]

{ #category : #API }
Z3ParameterSet >> at: aZ3Symbol putUint: v [
	LibZ3 uniqueInstance paramsSetUint: ctx p: self symbol: aZ3Symbol unsigned: v
]

{ #category : #API }
Z3ParameterSet >> paramsToString [
	^ LibZ3 uniqueInstance paramsToString: ctx p: self
]
