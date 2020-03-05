"
Fixed-point machine-arithmetic integer (i.e., integer mod word size).
"
Class {
	#name : #BitVector,
	#superclass : #AST,
	#category : #'MachineArithmetic-Bits'
}

{ #category : #private }
BitVector class >> fromExternalID: anExternalID [ 
	| op |
	op := self opOf: anExternalID.
	op = 'BVV' ifTrue: [ ^IntValue var: anExternalID ].
	op = 'BVS' ifTrue: [ ^IntSymbol  var: anExternalID ].
	^BitVector var: anExternalID 
]

{ #category : #private }
BitVector class >> pythonClassName [ 
	^'BV'
]

{ #category : #'logical operations' }
BitVector >> & aNumber [
	^ self bitAnd: aNumber
]

{ #category : #arithmetic }
BitVector >> * aNumber [
	| ref |
	ref := self ref, ' * ', aNumber ref.
	^self class simplify: ref
]

{ #category : #arithmetic }
BitVector >> + aNumber [
	| ref |
	ref := self ref, ' + ', aNumber ref.
	^self class simplify: ref
]

{ #category : #arithmetic }
BitVector >> , aNumber [
	| ref |
	ref := 'Concat( ', self ref, ' , ', aNumber ref, ')'.
	^self class simplify: ref
]

{ #category : #arithmetic }
BitVector >> - aNumber [
	| ref |
	ref := self ref, ' - ', aNumber ref.
	^self class simplify: ref
]

{ #category : #arithmetic }
BitVector >> / aNumber [
	| ref |
	ref := self ref, ' / ', aNumber ref.
	^self class simplify: ref
]

{ #category : #arithmetic }
BitVector >> /- aNumber [
	| ref |
	ref := 'SDiv ( ', self ref, ' , ', aNumber ref, ' )'.
	^self class simplify: ref
]

{ #category : #arithmetic }
BitVector >> << aNumber [ 
	| ref |
	ref := self ref, ' << ', aNumber ref.
	^P compute: ref

]

{ #category : #converting }
BitVector >> asBitVector: length [
	self length = length ifFalse: [ ^self error ].
	^self
]

{ #category : #'logical operations' }
BitVector >> bitAnd: n [ 
	"Answer a bit vector whose bits are the logical AND of the receiver's bits  
	and those of the argument, n."
	| ref |
	ref := self ref, ' & ', n ref.
	^self class simplify: ref
]

{ #category : #'logical operations' }
BitVector >> bitInvert [
	"Answer a bit vector whose bits are the logical negation of the receiver's bits."
	^P compute: '~(', self ref, ')'

]

{ #category : #'logical operations' }
BitVector >> bitOr: n [ 
	"Answer a bit vector whose bits are the logical OR of the receiver's bits  
	and those of the argument, n."
	| ref |
	ref := self ref, ' | ', n ref.
	^self class simplify: ref
]

{ #category : #slicing }
BitVector >> copyFrom: start to: stop [
	"This is like the usual SequenceableCollection>>copyFrom:to:,
	but NB the numbering of bits: right-to-left, the LSB is bit 0."
	^P compute: self ref, '[ ', start printString, ':', stop printString, ' ]'
]

{ #category : #access }
BitVector >> length [
	^P eval: self ref, '.size()'
]

{ #category : #arithmetic }
BitVector >> reversed [
	"Answer the endian-reversed myself"
	| ref |
	ref := self ref, '.reversed'.
	^P compute: ref

]

{ #category : #slicing }
BitVector >> subrange: anInterval [
	"Similar to copyFrom:to:, but the range is given by anInterval."
	anInterval increment == -1 ifFalse: [ self shouldBeImplemented ].
	^P compute: self ref, '[ ', anInterval first printString, ':', anInterval last printString, ' ]'
]

{ #category : #'logical operations' }
BitVector >> | anInteger [
	^self bitOr: anInteger
]
