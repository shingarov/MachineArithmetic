Extension { #name : #String }

{ #category : #'*PreSmalltalks-FxEncoding' }
String >> decodeUnsafe [
	| in out |
	in := ReadStream on: self.
	out := WriteStream on: String new.
	[ in atEnd ] whileFalse: [ | c |
			c := in next.
			c = $ß
				ifTrue: [ | codePoint |
					codePoint := Integer readFrom: (in upTo: $ß).
					out nextPut: (Character codePoint: codePoint)
				] ifFalse: [
					out nextPut: c
				]
		].
	^out contents
	"
	'vß35ß3ß35ßß35ß1' decodeUnsafe  → 'v#3##1'
	"
]

{ #category : #'*PreSmalltalks-FxEncoding' }
String >> encodeUnsafe [
"
encodeUnsafe :: T.Text -> T.Text
Cf. Names.hs
In Smalltalk, we want to satisfy stricter requirements:
we want our symbols to be valid Z3 symbols (even after passing
through FFI) AND be valid Smalltalk names.
Therefore '$' is not a safe character; but 'ß' is.
"
	| c cs head tail |
	self isEmpty ifTrue: [ ^ self ].
	c := self first.
	cs := self allButFirst.
	head := (c isUnsafeChar and: c~~$ß)
		ifTrue: [ 'ß' , c codePoint printString , 'ß' ]
		ifFalse: [ String with: c ].
	tail := cs encodeUnsafe.
	^ head , tail
]
