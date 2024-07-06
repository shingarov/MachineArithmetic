Extension { #name : #String }

{ #category : #'*PreSmalltalks-ZEncoding' }
String >> zencode [
	| out |
	out := WriteStream on: String new.
	out nextPut: $z.
	self do: [ :char | char printZOn: out ].
	^out contents
]
