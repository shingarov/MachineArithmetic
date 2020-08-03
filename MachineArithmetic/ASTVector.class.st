Class {
	#name : #ASTVector,
	#superclass : #Z3ContextedObject,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
ASTVector class >> parseSmtlib2String: aString [
	^self parseSmtlib2String: aString in: Z3Context current
]

{ #category : #'instance creation' }
ASTVector class >> parseSmtlib2String: aString in: ctx [
	| instance |
	instance := ctx parseSmtlib2String: aString.
	instance incRef.
	^instance
]

{ #category : #printing }
ASTVector >> astVectorToString [
	^LibZ3 uniqueInstance astVectorToString: ctx astVector: self
]

{ #category : #'ref-counting' }
ASTVector >> decRef [
	self class unwrapAround: self.
	LibZ3 uniqueInstance decRef: ctx astVector: self.
	self poison.
	
]

{ #category : #'ref-counting' }
ASTVector >> incRef [
	LibZ3 uniqueInstance incRef: ctx astVector: self
]

{ #category : #printing }
ASTVector >> printOn: aStream [
	aStream nextPutAll: self astVectorToString

]
