Extension { #name : #SequenceableCollection }

{ #category : #'*MachineArithmetic' }
SequenceableCollection >> ensureValidZ3ASTArray [
	self do:[:each | each ensureValidZ3AST ]
]

{ #category : #'*MachineArithmetic' }
SequenceableCollection >> ensureValidZ3ASTArrayOfKind: kind [
	self do:[:each | each ensureValidZ3ASTOfKind: kind ]
]

{ #category : #'*MachineArithmetic' }
SequenceableCollection >> ensureValidZ3ObjectArray [
	self do:[:each | each ensureValidZ3Object ]
]
