Class {
	#name : #Z3ReferenceCountedObject,
	#superclass : #Z3ContextedObject,
	#category : #'Z3-Core'
}

{ #category : #'ref-counting' }
Z3ReferenceCountedObject >> decRef [
	self subclassResponsibility

]

{ #category : #'ref-counting' }
Z3ReferenceCountedObject >> incRef [
	self subclassResponsibility

]

{ #category : #initialization }
Z3ReferenceCountedObject >> initializeWithAddress: anExternalAddress context: aZ3Context [
	super initializeWithAddress: anExternalAddress context: aZ3Context.
	self incRef.

]

{ #category : #initialization }
Z3ReferenceCountedObject >> release [
	self decRef.
	super release

]
