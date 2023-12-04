Extension { #name : #Form }

{ #category : #'*MathNotation-Pharo' }
Form >> printOn: aStream [
	aStream collectionSpecies = Text ifTrue: [
		aStream
			withAttribute: (TextAnchor new anchoredMorph: self)
			do: [ aStream nextPutAll: (String value: 1) ].
		^self ].
	aStream
        nextPutAll: self class name;
        nextPut: $(; print: width;
        nextPut: $x; print: height;
        nextPut: $x; print: depth;
        nextPut: $).
]
