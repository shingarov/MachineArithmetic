Class {
	#name : #Z3ASTVector,
	#superclass : #Z3ContextedObject,
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
	^LibZ3 uniqueInstance astVectorToString: ctx astVector: self
]

{ #category : #'ref-counting' }
Z3ASTVector >> decRef [
	self class unwrapAround: self.
	LibZ3 uniqueInstance decRef: ctx astVector: self.
	self poison.
	
]

{ #category : #'ref-counting' }
Z3ASTVector >> incRef [
	LibZ3 uniqueInstance incRef: ctx astVector: self
]

{ #category : #printing }
Z3ASTVector >> printOn: aStream [
	aStream nextPutAll: self astVectorToString
]
