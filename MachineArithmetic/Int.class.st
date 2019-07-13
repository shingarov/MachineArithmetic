"
Fixed-point machine-arithmetic integer (i.e., integer mod word size).
"
Class {
	#name : #Int,
	#superclass : #Object,
	#instVars : [
		'var'
	],
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
Int class >> opOf: anExternalID [
	^P eval: anExternalID ref, '.op'
]

{ #category : #'instance creation' }
Int class >> value: x length: l [
	^self subclassResponsibility
]

{ #category : #private }
Int class >> var: v [
	^self new 
		var: v;
		yourself
]

{ #category : #arithmetic }
Int >> + aNumber [
	| ref |
	ref := self ref, ' + ', aNumber ref.
	^P fetchVar: (P evalAndAssign: ref)

]

{ #category : #arithmetic }
Int >> - aNumber [
	| ref |
	ref := self ref, ' - ', aNumber ref.
	^P fetchVar: (P evalAndAssign: ref)

]

{ #category : #arithmetic }
Int >> << aNumber [ 
	| ref |
	ref := self ref, ' << ', aNumber ref.
	^P fetchVar: (P evalAndAssign: ref)

]

{ #category : #access }
Int >> length [
	^P eval: self ref, '.size()'
]

{ #category : #access }
Int >> op [
	^self class opOf: self var
]

{ #category : #printing }
Int >> printOn: aStream [
	aStream nextPutAll: self var pythonStr
]

{ #category : #private }
Int >> ref [ 
	^self var ref
]

{ #category : #private }
Int >> var [
	^ var
]

{ #category : #private }
Int >> var: anExternalID [
	var := anExternalID
]
