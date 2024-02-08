Extension { #name : #TypingJudgement }

{ #category : #'*MathNotation' }
TypingJudgement >> isSelfEvaluating [
	^term isSelfEvaluating and:[type isSelfEvaluating]
]

{ #category : #'*MathNotation' }
TypingJudgement >> printOn: aStream [
	self storeOn: aStream
]

{ #category : #'*MathNotation' }
TypingJudgement >> storeOn: aStream [
	| scanner termString typeString |

	"Try to put parenthesis around term and type
	 when needed.
	"
	scanner := RBScanner new initializeClassificationTable.

	termString := term printString.
	(termString anySatisfy:[:char | | charCls | (charCls := scanner classify: char) ~~ #alphabetic and:[ charCls ~~ #digit ]]) ifTrue:[
		aStream nextPut:$(.
		term printOn: aStream.
		aStream nextPut:$).
	] ifFalse:[
		term printOn: aStream
	].

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
