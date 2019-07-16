"
An Int known to be given to be a certain cosa, X.
"
Class {
	#name : #IntSymbol,
	#superclass : #Int,
	#category : #'MachineArithmetic-Bits'
}

{ #category : #'instance creation' }
IntSymbol class >> sym: sym length: l [
	^self construct: 'claripy.BVS(', sym printString, ',', l printString, ', explicit_name=True)'
]

{ #category : #converting }
IntSymbol >> asBitVector: length [
	self length = length ifTrue: [ ^self ].
	self error 
]

{ #category : #sibstitution }
IntSymbol >> inEnvironment: aDictionary [
	| value |
	value := aDictionary at: self sym ifAbsent: [ ^self ].
	^value asBitVector: self length.
]

{ #category : #testing }
IntSymbol >> isLeaf [ 
	^true
]

{ #category : #access }
IntSymbol >> sym [
	^P eval: self ref, '.args[0]'
]
