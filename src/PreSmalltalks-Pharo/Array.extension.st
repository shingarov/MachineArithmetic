Extension { #name : #Array }

{ #category : #'*PreSmalltalks-Pharo' }
Array >> storeOn: aStream [
	"Use the literal form if possible."

	self shouldBePrintedAsLiteral
		ifTrue:
			[aStream nextPut: $#; nextPut: $(.
			self do:
				[:element |
				element storeOn: aStream.
				aStream space].
			aStream nextPut: $).
			^self].
	self isSelfEvaluating
			ifTrue:
			[aStream nextPut: ${.
			self do: [:element | element storeOn: aStream]
					separatedBy:[aStream nextPut: $.; space].
			aStream nextPut: $}.
			^self].
	^ super storeOn: aStream

	"
	#(1 2 3) storeString.
	{ Integer . 1 -> true } storeString
	{ Object new } storeString
	"
]
