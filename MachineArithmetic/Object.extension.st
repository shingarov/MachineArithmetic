Extension { #name : #Object }

{ #category : #'*MachineArithmetic' }
Object >> asZ3Symbol [
	^Z3Symbol from: self
]

{ #category : #'*MachineArithmetic' }
Object >> isAST [
	^false
]

{ #category : #'*MachineArithmetic' }
Object >> isBitVector [ 
	^false
]

{ #category : #'*MachineArithmetic' }
Object >> isInt [ 
	^false
]

{ #category : #'*MachineArithmetic' }
Object >> isReal [
	^false
]
