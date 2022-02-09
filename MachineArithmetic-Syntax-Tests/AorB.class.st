Class {
	#name : #AorB,
	#superclass : #Object,
	#instVars : [
		'x'
	],
	#category : #'MachineArithmetic-Syntax-Tests'
}

{ #category : #'instance creation' }
AorB class >> with: x [
	^self new x: x; yourself
]

{ #category : #accessing }
AorB >> x [
	^ x
]

{ #category : #accessing }
AorB >> x: anObject [
	x := anObject
]
