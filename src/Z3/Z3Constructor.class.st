Class {
	#name : #Z3Constructor,
	#superclass : #Z3ContextedObject,
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
Z3Constructor class >> name: constructorName recognizer: recognizerName fields: fields referencing: sortRefs [
	^Z3Context current
				mkConstructor: constructorName
				recognizer: recognizerName
				fields: fields
				referencing: sortRefs
]

{ #category : #'initialization & release' }
Z3Constructor >> delete [
	Z3 del_constructor: ctx _: self
]

{ #category : #accessing }
Z3Constructor >> numFields [
	^Z3 constructor_num_fields: ctx _: self
]

{ #category : #accessing }
Z3Constructor >> query [
	^Z3Context current queryConstructor: self
]
