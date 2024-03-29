Extension { #name : #RBScanner }

{ #category : #'*MathNotation-Pharo' }
RBScanner >> classify: aCharacter [
	| index |
	aCharacter ifNil: [ ^ nil ].
	(self isUnicodeBinary: aCharacter) ifTrue: [ ^ #binary ].
	index := aCharacter asInteger.
	index == 0
		ifTrue: [ ^ #separator ].
	index > 255 ifTrue: [
		aCharacter isLetter     ifTrue: [ ^#alphabetic ].
		aCharacter isSeparator  ifTrue: [ ^#separator  ].
		aCharacter isSpecial    ifTrue: [ ^#special    ].
		^nil ].
	^ classificationTable at: index
]

{ #category : #'*MathNotation-Pharo' }
RBScanner >> isBinary [
	characterType = #binary
		ifTrue: [ [ characterType = #binary ] whileTrue: [ self step ].
			^ characterType = #eof ].
	^false
]

{ #category : #'*MathNotation-Pharo' }
RBScanner class >> isBinary: aSymbol [
	| scanner |
	scanner := self basicNew.
	scanner on: (ReadStream on: aSymbol asString).
	scanner step.
	^ scanner isBinary
]

{ #category : #'*MathNotation-Pharo' }
RBScanner >> isUnicodeArrow: aCharacter [
	^#(16r2190 16r2191 16r2192 16r2193 "only the first 4 of the Arrows block appear to work"
	) includes: aCharacter asInteger

]

{ #category : #'*MathNotation-Pharo' }
RBScanner >> isUnicodeBinary: aCharacter [
	^ (self isUnicodeArrow: aCharacter) or:[self isUnicodeMathOperator: aCharacter]

]

{ #category : #'*MathNotation-Pharo' }
RBScanner >> isUnicodeInfix: aCharacter [
	^#(
	16r2208
	)
	includes: aCharacter asInteger

"#(
	16r2202 16r2206 16r2208 16r220F
	16r2211 16r2212 16r2215 16r2219 16r221A 16r221E
	16r222B 16r2248 16r2260 16r2264 16r2265
	) 
	collect: [ :codepoint | Character value: codepoint ]"
]

{ #category : #'*MathNotation-Pharo' }
RBScanner >> isUnicodeMathOperator: aCharacter [
	"Unicode binary selectors"
	^ #(
		"From 8-bit block"
		16rD7  " × "
		16rF7  " ÷ "
		
		"From 'Arrows' block"
		16r21F4" ⇴ "
		
		"From 'Mathematical Operators' block"
		16r2208" ∈ "
		16r2209" ∉ "
		16r2218" ∘ "
		16r2229" ∩ "
		16r222A" ∪ "
		16r2243" ≃ "
		16r2245" ≅ "
		16r225B" ≛ "
		16r2264" ≤ "
		16r2265" ≥ "
		16r227A" ≺ "
		16r227B" ≻ "
		16r2286" ⊆ "
		16r2295" ⊕ "
		16r2296" ⊖ "
		16r2297" ⊗ "
		16r229B" ⊛ "
		16r22B2" ⊲ "
		16r22B3" ⊳ "
		
		"From 'Supplemental Mathematical Operators' block"
		16r2A30" ⨰ "
		
	)	includes: aCharacter asInteger
]
