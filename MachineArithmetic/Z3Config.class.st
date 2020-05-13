Class {
	#name : #Z3Config,
	#superclass : #FFIIdentityObject,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Z3Config class >> default [
	^ LibZ3 uniqueInstance mkConfig 
]
