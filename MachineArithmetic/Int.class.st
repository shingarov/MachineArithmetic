"
Fixed-point machine-arithmetic integer (i.e., integer mod word size).
"
Class {
	#name : #Int,
	#superclass : #AST,
	#category : #'MachineArithmetic-Bits'
}

{ #category : #private }
Int class >> fromExternalID: anExternalID [ 
	| op |
	op := self opOf: anExternalID.
	op = 'BVV' ifTrue: [ ^IntValue var: anExternalID ].
	op = 'BVS' ifTrue: [ ^IntSymbol  var: anExternalID ].
	^Int var: anExternalID 
]

{ #category : #private }
Int class >> pythonClassName [ 
	^'BV'
]

{ #category : #'logical operations' }
Int >> & aNumber [
	^ self bitAnd: aNumber
]

{ #category : #arithmetic }
Int >> + aNumber [
	| ref |
	ref := self ref, ' + ', aNumber ref.
	^self class simplify: ref
]

{ #category : #arithmetic }
Int >> , aNumber [
	| ref |
	ref := 'Concat( ', self ref, ' , ', aNumber ref, ')'.
	^self class simplify: ref
]

{ #category : #arithmetic }
Int >> - aNumber [
	| ref |
	ref := self ref, ' - ', aNumber ref.
	^self class simplify: ref
]

{ #category : #arithmetic }
Int >> << aNumber [ 
	| ref |
	ref := self ref, ' << ', aNumber ref.
	^P compute: ref

]

{ #category : #converting }
Int >> asBitVector: length [
	self length = length ifFalse: [ ^self error ].
	^self
]

{ #category : #'logical operations' }
Int >> bitAnd: n [ 
	"Answer a bit vector whose bits are the logical AND of the receiver's bits  
	and those of the argument, n."
	| ref |
	ref := self ref, ' & ', n ref.
	^self class simplify: ref
]

{ #category : #'logical operations' }
Int >> bitInvert [
	"Answer a bit vector whose bits are the logical negation of the receiver's bits."
	^P compute: '~(', self ref, ')'

]

{ #category : #'logical operations' }
Int >> bitOr: n [ 
	"Answer a bit vector whose bits are the logical OR of the receiver's bits  
	and those of the argument, n."
	| ref |
	ref := self ref, ' | ', n ref.
	^self class simplify: ref
]

{ #category : #slicing }
Int >> copyFrom: start to: stop [
	"This is like the usual SequenceableCollection>>copyFrom:to:,
	but NB the numbering of bits: right-to-left, the LSB is bit 0."
	^P compute: self ref, '[ ', start printString, ':', stop printString, ' ]'
]

{ #category : #access }
Int >> length [
	^P eval: self ref, '.size()'
]

{ #category : #arithmetic }
Int >> reversed [
	"Answer the endian-reversed myself"
	| ref |
	ref := self ref, '.reversed'.
	^P compute: ref

]

{ #category : #slicing }
Int >> subrange: anInterval [
	"Similar to copyFrom:to:, but the range is given by anInterval."
	anInterval increment == -1 ifFalse: [ self shouldBeImplemented ].
	^P compute: self ref, '[ ', anInterval first printString, ':', anInterval last printString, ' ]'
]

{ #category : #'logical operations' }
Int >> | anInteger [
	^self bitOr: anInteger
]
