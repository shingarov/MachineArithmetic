Class {
	#name : #Z3Constructor,
	#superclass : #Z3ContextedObject,
	#category : #'Z3-Core'
}

{ #category : #'initialization & release' }
Z3Constructor >> delete [
	Z3 del_constructor: ctx _: self
]
