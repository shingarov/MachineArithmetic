Class {
	#name : #ZEncodingTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

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
