Extension { #name : #Character }

{ #category : #'*PreSmalltalks-FxEncoding' }
Character >> isUnsafeChar [
"
isUnsafeChar :: Char -> Bool
Cf. Names.hs
"
	^(Character okSymChars includes: self) not
]

{ #category : #'*PreSmalltalks-FxEncoding' }
Character class >> okSymChars [
	^($a to: $z),
	 ($A to: $Z),
	 ($0 to: $9),
	 {$_}
]
