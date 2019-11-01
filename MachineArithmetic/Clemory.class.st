Class {
	#name : #Clemory,
	#superclass : #External,
	#category : #'MachineArithmetic-SymSim'
}

{ #category : #private }
Clemory class >> pythonClassName [ 
	^'Clemory'
]

{ #category : #GT }
Clemory >> allBackers [
	| backerListVar len backers |
	backerListVar := P evalAndAssign:  '[ (start, backer) for start, backer in ', self backers ref, ']'.
	len := P compute: 'len(', backerListVar ref , ')'.
	backers := Dictionary new.
	0 to: len - 1 do: [ :j |
		| startAddr bytes |
		startAddr := P compute: backerListVar ref, '[', j printString, '][0]'.
		bytes     := "P compute: backerListVar ref, '[', j printString, '][1]'." 'FIXME: bytearray may be too long'.
		backers at: startAddr put: bytes ].
	^backers

]

{ #category : #GT }
Clemory >> gtInspectorItemsIn: composite [
	^ (composite fastTable)
		title: 'All backers';
		display: [ self allBackers associations ];
		column: 'Address' 
			evaluated: [:each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Bytes' 
			evaluated: [:each | GTObjectPrinter asTruncatedTextFrom: each value ];
		selectionPopulate: #selection 
			entitled: 'Open key'
			with: [ :table | (table rawSelection collect: #key) gtInspectorInterestingObject ];
		beSingle;
		send: [ :selection | 
			selection isNil 
			ifTrue:[nil]
			ifFalse:[ (selection size = 1) 
				ifTrue: [ selection anyOne value ] 
				ifFalse: [ selection collect: #value ] ]]
		
]
