Class {
	#name : #Z3ConstructorList,
	#superclass : #Z3ContextedObject,
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
Z3ConstructorList class >> withAll: constructors [
	^Z3Context current mkConstructorList: constructors
]

{ #category : #'initialization & release' }
Z3ConstructorList >> delete [
	Z3 del_constructor_list: ctx _: self
]
