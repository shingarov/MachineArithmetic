Extension { #name : #VariableAlphabet }

{ #category : #'*SpriteLang' }
VariableAlphabet class >> uniqueVariableNameFor: original [
	j isNil ifTrue: [ j:= 0 ].
	j := j + 1.
	^String streamContents: [ :s|
		s nextPutAll: original.
		s nextPutAll: '__ß'.
		j printOn: s base: 10 nDigits: 6
	].

	"
	VariableAlphabet uniqueVariableNameFor: 'x'
	"
]
