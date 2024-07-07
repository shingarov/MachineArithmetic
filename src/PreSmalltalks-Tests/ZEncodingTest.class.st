Class {
	#name : #ZEncodingTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #'tests-decoding' }
ZEncodingTest >> testDecodeA [
	self
		assert: 'zA' zdecode
		equals: 'A'
]

{ #category : #'tests-decoding' }
ZEncodingTest >> testDecodeBraces [
	self
		assert: 'zzTzV' zdecode
		equals: '{}'
]

{ #category : #'tests-decoding' }
ZEncodingTest >> testDecodeCaret [
	self
		assert: 'zzQ' zdecode
		equals: '^'
]

{ #category : #'tests-decoding' }
ZEncodingTest >> testDecodeFail1 [
	self
		should: ['ABC' zdecode]
		raise: Error
]

{ #category : #'tests-decoding' }
ZEncodingTest >> testDecodeFullStop [
	self
		assert: 'zzE' zdecode
		equals: '.'
]

{ #category : #'tests-decoding' }
ZEncodingTest >> testDecodeHash [
	self
		assert: 'zaz3b' zdecode
		equals: 'a#b'
]

{ #category : #'tests-decoding' }
ZEncodingTest >> testDecodeLT [
	self
		assert: 'zzI' zdecode
		equals: '<'
]

{ #category : #'tests-decoding' }
ZEncodingTest >> testDecodePlus [
	self
		assert: 'zAzBB' zdecode
		equals: 'A+B'
]

{ #category : #'tests-decoding' }
ZEncodingTest >> testDecodeZ [
	self
		assert: 'zzz' zdecode
		equals: 'z'
]

{ #category : #'tests-encoding' }
ZEncodingTest >> testEncodeA [
	self
		assert: 'a' zencode
		equals: 'za'
]

{ #category : #'tests-encoding' }
ZEncodingTest >> testEncodeBraces [
	self
		assert: '{}' zencode
		equals: 'zzTzV'
]

{ #category : #'tests-encoding' }
ZEncodingTest >> testEncodeCaret [
	self
		assert: '^' zencode
		equals: 'zzQ'
]

{ #category : #'tests-encoding' }
ZEncodingTest >> testEncodeFullStop [
	self
		assert: '.' zencode
		equals: 'zzE'
]

{ #category : #'tests-encoding' }
ZEncodingTest >> testEncodeLT [
	self
		assert: '<' zencode
		equals: 'zzI'
]

{ #category : #'tests-encoding' }
ZEncodingTest >> testEncodePlus [
	self
		assert: 'A+B' zencode
		equals: 'zAzBB'
]

{ #category : #'tests-encoding' }
ZEncodingTest >> testEncodeZ [
	self
		assert: 'z' zencode
		equals: 'zzz'
]
