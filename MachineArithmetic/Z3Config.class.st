Class {
	#name : #Z3Config,
	#superclass : #Z3Object,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Z3Config class >> default [
	^ Z3 mk_config 

]
