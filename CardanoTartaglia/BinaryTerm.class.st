Class {
	#name : #BinaryTerm,
	#superclass : #ApplicationTerm,
	#category : #CardanoTartaglia
}

{ #category : #printing }
BinaryTerm >> printOn: aStream [
	aStream nextPut: $(.
	receiver printOn: aStream.
	aStream nextPutAll: message selector asString.
	message argument printOn: aStream.
	aStream nextPut: $)
		
]
