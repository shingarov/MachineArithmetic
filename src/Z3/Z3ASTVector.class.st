Class {
	#name : #Z3ASTVector,
	#superclass : #Z3ReferenceCountedObject,
	#category : #'Z3-Core'
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

{ #category : #solving }
Z3ASTVector >> assertIn: aSolver [
	self contents do: [ :th | aSolver assert: th ]
]

{ #category : #printing }
Z3ASTVector >> astVectorToString [
	^Z3 ast_vector_to_string: ctx _: self

]

{ #category : #accessing }
Z3ASTVector >> at: i [
	^Z3 ast_vector_get: ctx _: self _: i-1
]

{ #category : #accessing }
Z3ASTVector >> contents [ 
	^(1 to: self size) collect: [ :i | self at: i ]

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

{ #category : #accessing }
Z3ASTVector >> size [ 
	^Z3 ast_vector_size: ctx _: self
]
