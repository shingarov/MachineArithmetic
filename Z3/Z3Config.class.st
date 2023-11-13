Class {
	#name : #Z3Config,
	#superclass : #Z3Object,
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
Z3Config class >> default [
	^ Z3 mk_config 

]
