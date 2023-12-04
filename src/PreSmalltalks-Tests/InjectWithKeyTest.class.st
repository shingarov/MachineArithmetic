Class {
	#name : #InjectWithKeyTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
InjectWithKeyTest >> exampleDictionary [
	^Dictionary new 
		at: 1 put: 'A';
		at: 2 put: 'B';
		yourself
]

{ #category : #tests }
InjectWithKeyTest >> keysOf: aDictionary [
	^(aDictionary injectWithKey: #() into: [ :ks :k :x | {k.}, ks ]) reversed
]

{ #category : #tests }
InjectWithKeyTest >> testKeys [ 
	"Classic example of foldlWithKey:
	keys = reverse . foldlWithKey (λks k x -> k:ks) []
	"
	| d |
	d := self exampleDictionary.
	self assert: (self keysOf: d) equals: d keys
]

{ #category : #tests }
InjectWithKeyTest >> testPrintInvert [
	"Another classic example of foldlWithKey, taken from Hackage."
	| string |
	string := self exampleDictionary injectWithKey: 'Dictionary: ' into: [ :result :k :a | result, '(', k printString, ':' , a, ')' ].
	self assert: string equals: 'Dictionary: (1:A)(2:B)'
]
