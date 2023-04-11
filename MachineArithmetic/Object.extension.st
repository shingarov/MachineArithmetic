Extension { #name : #Object }

{ #category : #'*MachineArithmetic' }
Object >> ensureValidZ3Object [
	"The receiver is not even a Z3Object, let alone a valid one."
	^InvalidZ3Object object: self
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
Object >> isBool [
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

{ #category : #'*MachineArithmetic' }
Object >> toBitVector: length [
	self error: 'No automatic coerction to BitVector, please coerce manually'
]

{ #category : #'*MachineArithmetic' }
Object >> toBool [
	self error: 'No automatic coerction to Bool, please coerce manually'
]

{ #category : #'*MachineArithmetic' }
Object >> toInt [
	self error: 'No automatic coerction to Int, please coerce manually'
]

{ #category : #'*MachineArithmetic' }
Object >> toReal [
	self error: 'No automatic coerction to Real, please coerce manually'
]

{ #category : #'*MachineArithmetic' }
Object >> toZ3Symbol [
	^Z3Symbol from: self
]
