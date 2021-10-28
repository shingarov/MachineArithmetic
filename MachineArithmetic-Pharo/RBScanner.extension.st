Extension { #name : #RBScanner }

{ #category : #'*MachineArithmetic-Pharo' }
RBScanner >> classify: aCharacter [
	| index |
	aCharacter ifNil: [ ^ nil ].
	(self isUnicodeBinary: aCharacter) ifTrue: [ ^ #binary ].
	index := aCharacter asInteger.
	index == 0
		ifTrue: [ ^ #separator ].
	index > 255
		ifTrue: [ ^ aCharacter isLetter
				ifTrue: [ #alphabetic ]
				ifFalse: [ aCharacter isSeparator
						ifTrue: [ #separator ]
						ifFalse: [ nil ]
					]
			].
	^ classificationTable at: index
]

{ #category : #'*MachineArithmetic-Pharo' }
RBScanner >> isUnicodeArrow: aCharacter [
	^#(16r2190 16r2191 16r2192 16r2193 "only the first 4 of the Arrows block appear to work"
	) includes: aCharacter asInteger

]

{ #category : #'*MachineArithmetic-Pharo' }
RBScanner >> isUnicodeBinary: aCharacter [
	^ self isUnicodeArrow: aCharacter

]

{ #category : #'*MachineArithmetic-Pharo' }
RBScanner >> isUnicodeMathOperator: aCharacter [
	"a few from the Math Operators block appear to work"
	^#(
	16r2202 16r2206 16r220F
	16r2211 16r2212 16r2215 16r2219 16r221A 16r221E
	16r222B 16r2248 16r2260 16r2264 16r2265
	) 
	"collect: [ :codepoint | Character value: codepoint ]"
	includes: aCharacter asInteger

]
