Extension { #name : #Object }

{ #category : #'*Z3' }
Object >> adaptToBitVector: receiver length: length andSend: selector [
	^receiver perform: selector with: (self toBitVector: length)
]

{ #category : #'*Z3' }
Object >> adaptToBool: receiver andSend: selector [
	^receiver perform: selector with: self toBool
]

{ #category : #'*Z3' }
Object >> adaptToInt: receiver andSend: selector [
	^receiver perform: selector with: self toInt
]

{ #category : #'*Z3' }
Object >> adaptToReal: receiver andSend: selector [
	^receiver perform: selector with: self toReal
]

{ #category : #'*Z3' }
Object >> ensureValidZ3AST [
	"This method is no-op if the object appears to be valid
	 (based on the pointer value) and if it's an AST (based
	 on receiver's class)."

	self error:'Invalid Z3 AST (not an Z3AST instance)!'
]

{ #category : #'*Z3' }
Object >> ensureValidZ3ASTArray [
	"This method is no-op if the object appears to be valid
	 array of valid Z3 ASTs. Throws an error otherwise."

	self error:'Invalid Z3 AST array (not an array)!'
]

{ #category : #'*Z3' }
Object >> ensureValidZ3ASTArrayOfKind: kind [
	"This method is no-op if the object appears to be valid
	 array of valid Z3 ASTs of given kind. Throws an error otherwise."

	self error:'Invalid Z3 AST array (not an array)!'
]

{ #category : #'*Z3' }
Object >> ensureValidZ3ASTOfKind: kind [
	"This method is no-op if the object appears to be valid
	 (based on the pointer value) and if it's an AST of given
	 kind (based on receiver's kind)."

	self error:'Invalid Z3 AST (not an Z3AST instance)!'
]

{ #category : #'*Z3' }
Object >> ensureValidZ3Object [
	"This method is no-op if the object appears to be valid
	 Z3 object (based on the pointer value). Othwewise, 
	 throw and error."                 

	self error:'Invalid Z3 object (not a Z3 object)!'
]

{ #category : #'*Z3' }
Object >> ensureValidZ3ObjectArray [
	"This method is no-op if the object appears to be valid
	 array of valid Z3 objects. Throws an error otherwise."

	self error:'Invalid Z3 object array (not an array)!'
]

{ #category : #'*Z3' }
Object >> isAST [
	^false
]

{ #category : #'*Z3' }
Object >> isBitVector [ 
	^false
]

{ #category : #'*Z3' }
Object >> isBool [
	^false
]

{ #category : #'*Z3' }
Object >> isInt [ 
	^false
]

{ #category : #'*Z3' }
Object >> isNode [
	^false
]

{ #category : #'*Z3' }
Object >> isReal [
	^false
]

{ #category : #'*Z3' }
Object >> isZ3Symbol [
	^ false
]

{ #category : #'*Z3' }
Object >> toBitVector: length [
	self error: 'No automatic coerction to BitVector, please coerce manually'
]

{ #category : #'*Z3' }
Object >> toBool [
	self error: 'No automatic coerction to Bool, please coerce manually'
]

{ #category : #'*Z3' }
Object >> toInt [
	self error: 'No automatic coerction to Int, please coerce manually'
]

{ #category : #'*Z3' }
Object >> toReal [
	self error: 'No automatic coerction to Real, please coerce manually'
]

{ #category : #'*Z3' }
Object >> toZ3Symbol [
	^Z3Symbol from: self
]
