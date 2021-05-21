Class {
	#name : #Z3ASTVector,
	#superclass : #Z3ReferenceCountedObject,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Z3ASTVector class >> parseSmtlib2String: aString [
	^self parseSmtlib2String: aString in: Z3Context current
]

{ #category : #'instance creation' }
Z3ASTVector class >> parseSmtlib2String: aString in: ctx [
	| instance |
	instance := ctx parseSmtlib2String: aString.
	instance incRef.
	^instance
]

{ #category : #printing }
Z3ASTVector >> astVectorToString [
	^Z3 ast_vector_to_string: ctx _: self

]

{ #category : #'ref-counting' }
Z3ASTVector >> decRef [
	Z3 ast_vector_dec_ref: ctx _: self.

]

{ #category : #'ref-counting' }
Z3ASTVector >> incRef [
	Z3 ast_vector_inc_ref: ctx _: self.

]

{ #category : #printing }
Z3ASTVector >> printOn: aStream [
	aStream nextPutAll: self astVectorToString
]
