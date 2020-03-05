Extension { #name : #Object }

{ #category : #'*MachineArithmetic' }
Object >> printForRegisterInspector [
	^self printString
]

{ #category : #'*MachineArithmetic' }
Object class >> registerPythonDeserializer [
	P registerClass: self
]

{ #category : #'*MachineArithmetic' }
Object >> symSimState [
	self shouldBeImplemented.
"	SimState arch: #bogus.  "
]
