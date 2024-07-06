Extension { #name : #Character }

{ #category : #'*PreSmalltalks-ZEncoding' }
Character >> printZOn: aStream [
	| c |
	c := self codePoint.
	c<=41 ifTrue: [ ^aStream nextPut: $z; nextPut: (Character codePoint: c+16) ].
	c<=47 ifTrue: [ ^aStream nextPut: $z; nextPut: (Character codePoint: c+23) ].
	c>57 & (c<=64) ifTrue: [ ^aStream nextPut: $z; nextPut: (Character codePoint: c+13) ].
	c>90 & (c<=94) | (c=96) ifTrue: [ ^aStream nextPut: $z; nextPut: (Character codePoint: c-13) ].
	c=16r7A ifTrue: [ ^aStream nextPut: $z; nextPut: $z ].
	c>122 & (c<=126) ifTrue: [ ^aStream nextPut: $z; nextPut: (Character codePoint: c-39) ].
	aStream nextPut: self
]
