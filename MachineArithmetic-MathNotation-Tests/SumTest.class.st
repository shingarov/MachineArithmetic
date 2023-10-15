Class {
	#name : #SumTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-MathNotation-Tests'
}

{ #category : #tests }
SumTest >> deserialize: jsonString as: aClass [
	| reader |
	reader := NeoJSONReader on: jsonString readStream.
	^reader nextAs: aClass
]

{ #category : #tests }
SumTest >> testJsonA [
	| obj |
	obj := self deserialize: '["A","asdf"]' as: AorB.
	self assert: obj s equals: 'asdf'
]

{ #category : #tests }
SumTest >> testJsonB [
	| obj |
	obj := self deserialize: '["B",42]' as: AorB.
	self assert: obj i equals: 42
]

{ #category : #tests }
SumTest >> testJsonBoth [
	| objs |
	objs := self deserialize: '[["A","asdf"],["B",42]]' as: AorB array.
	self assert: objs first s equals: 'asdf'.
	self assert: objs second i equals: 42.
]
