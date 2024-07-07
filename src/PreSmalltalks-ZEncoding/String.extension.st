Extension { #name : #String }

{ #category : #'*PreSmalltalks-ZEncoding' }
String >> zdecode [
	| out nextEncoded |
	self first = $z ifFalse: [ self error ].
	out := WriteStream on: String new.
	nextEncoded := false.
	self allButFirst do: [ :char |
		nextEncoded
			ifTrue: [
				| c cc |
				c := char codePoint.
				cc := c <= 57
					ifTrue: [ c - 16 ]
					ifFalse: [
						c <= 70
							ifTrue: [ c - 23 ]
							ifFalse: [
								c <= 77
									ifTrue: [ c - 13 ]
									ifFalse: [
										c <= 83
											ifTrue: [ c + 13 ]
											ifFalse: [
												c = 122
													ifTrue: [ 122 ]
													ifFalse: [
														c + 39
					]]]]].
				out nextPut: (Character codePoint: cc).
				nextEncoded := false.
			] ifFalse: [
				char = $z
					ifTrue: [ nextEncoded := true ]
					ifFalse: [ out nextPut: char ]
			]
	].
	^out contents
]

{ #category : #'*PreSmalltalks-ZEncoding' }
String >> zencode [
	| out |
	out := WriteStream on: String new.
	out nextPut: $z.
	self do: [ :char | char printZOn: out ].
	^out contents
]
