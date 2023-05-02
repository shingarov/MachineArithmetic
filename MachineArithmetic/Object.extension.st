Extension { #name : #Object }

{ #category : #'*MachineArithmetic' }
Object >> adaptToBitVector: receiver length: length andSend: selector [
	^receiver perform: selector with: (self toBitVector: length)
]

{ #category : #'*MachineArithmetic' }
Object >> adaptToBool: receiver andSend: selector [
	^receiver perform: selector with: self toBool
]

{ #category : #'*MachineArithmetic' }
Object >> adaptToInt: receiver andSend: selector [
	^receiver perform: selector with: self toInt
]

{ #category : #'*MachineArithmetic' }
Object >> adaptToReal: receiver andSend: selector [
	^receiver perform: selector with: self toReal
]

{ #category : #'*MachineArithmetic' }
Object >> ensureValidZ3AST [
	"This method is no-op if the object appears to be valid
	 (based on the pointer value) and if it's an AST (based
	 on receiver's class)."

	self error:'Invalid Z3 AST (not an Z3AST instance)!'
]


{ #category : #'*MachineArithmetic' }
Object >> ensureValidZ3ASTOfKind: kind [
	"This method is no-op if the object appears to be valid
	 (based on the pointer value) and if it's an AST of given
	 kind (based on receiver's kind)."

	self error:'Invalid Z3 AST (not an Z3AST instance)!'
]

{ #category : #'*MachineArithmetic' }
Object >> ensureValidZ3Object [
	"This method is no-op if the object appears to be valid
	 Z3 object (based on the pointer value). Othwewise, 
	 throw and error."                 

	self error:'Invalid Z3 object (not a Z3 object)!'
]
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
Object >> isNode [
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
