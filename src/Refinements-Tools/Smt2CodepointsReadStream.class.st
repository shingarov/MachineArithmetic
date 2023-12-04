Class {
	#name : #Smt2CodepointsReadStream,
	#superclass : #ReadStream,
	#category : #'Refinements-Tools'
}

{ #category : #API }
Smt2CodepointsReadStream >> contents [
	^self decodeSMT2on: (WriteStream on: String new)

]

{ #category : #decoding }
Smt2CodepointsReadStream >> decodeSMT2on: aWriteStream [
	| nextChar |
	self atEnd ifTrue: [ ^aWriteStream contents ].
	nextChar := self next.
	nextChar = $$
		ifTrue: [ aWriteStream nextPut: (Integer readFrom: (self upTo: $$)) asCharacter ]
		ifFalse: [ aWriteStream nextPut: nextChar ].
	^self decodeSMT2on: aWriteStream
]
