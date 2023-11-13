Class {
	#name : #Z3Pattern,
	#superclass : #Z3AST,
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
Z3Pattern class >> fromExternalAddress: anExternalAddress inContext: aZ3Context [
	^ aZ3Context internAST: Z3Pattern address: anExternalAddress
]

{ #category : #accessing }
Z3Pattern >> kind [ 
	self shouldBeImplemented 
]

{ #category : #printing }
Z3Pattern >> printOn: aStream [
	aStream nextPutAll: (Z3 pattern_to_string: ctx _: self)
]
