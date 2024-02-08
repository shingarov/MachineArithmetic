Extension { #name : #TypedSlot }

{ #category : #'*MathNotation' }
TypedSlot >> definitionString [
	| scanner typeString |

	"Try to put parenthesis around term and type
	 when needed.
	"
	scanner := RBScanner new initializeClassificationTable.

	^String streamContents: [ :aStream|
		name storeOn: aStream.
		aStream nextPutAll: ' ∷ '.

		typeString := type printString.
		(typeString anySatisfy:[:char | | charCls | (charCls := scanner classify: char) ~~ #alphabetic and:[ charCls ~~ #digit ]]) ifTrue:[
			aStream nextPut:$(.
			type printOn: aStream.
			aStream nextPut:$).
		] ifFalse:[
			type printOn: aStream
		].
	]
]
