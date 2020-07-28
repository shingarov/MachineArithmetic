Class {
	#name : #Z3Config,
	#superclass : #Z3IdentityObject,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Z3Config class >> default [
	^ LibZ3 uniqueInstance mkConfig 
]
