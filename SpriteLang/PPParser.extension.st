Extension { #name : #PPParser }

{ #category : #'*SpriteLang' }
PPParser >> annotationBrackets [
	^Character leftDoubleBracket asParser, self, Character rightDoubleBracket asParser
	==> [ :x | x second ]
]

{ #category : #'*SpriteLang' }
PPParser >> commaList [
	^self commaSeparated parens
]

{ #category : #'*SpriteLang' }
PPParser >> commaSeparated [
	| delimiter |
	delimiter := Object new.
	^(self separatedBy: $, asParser trim ==>[:_x|delimiter])
	==> [ :x | x reject: [ :tok | tok == delimiter ] ]
]
