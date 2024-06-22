Class {
	#name : #RBHoleToken,
	#superclass : #RBToken,
	#category : #'MathNotation-Pharo'
}

{ #category : #'concrete syntax' }
RBHoleToken class >> codePoint [
	"In the current implementation, we use $□ ('WHITE SQUARE', U+25A1)
	 to denote 'Hole' in concrete syntax, but any suitable character,
	 such as $– ('EN DASH' (U+2013), $☐ ('BALLOT BOX', U+2610), etc
	 should work, by changing ONLY this method."

	^16r25A1
]

{ #category : #testing }
RBHoleToken >> isHole [
	^true
]

{ #category : #accessing }
RBHoleToken >> length [
	^1
]
