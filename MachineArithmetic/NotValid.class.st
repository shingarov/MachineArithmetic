"
Attempt to prove some formula f universally-valid -- i.e., true for all assignments of variables -- has failed: we found a counterexample, i.e. such assignment of variables that made f false.
"
Class {
	#name : #NotValid,
	#superclass : #Error,
	#instVars : [
		'counterexample'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #signaling }
NotValid class >> counterexample: aCounterexample [
	^self new counterexample: aCounterexample; yourself
]

{ #category : #signaling }
NotValid class >> signalWithCounterexample: aCounterexample [
	^(self counterexample: aCounterexample) signal
]

{ #category : #accessing }
NotValid >> counterexample [
	^ counterexample
]

{ #category : #accessing }
NotValid >> counterexample: anObject [
	counterexample := anObject
]
