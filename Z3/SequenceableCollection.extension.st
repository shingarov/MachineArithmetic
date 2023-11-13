Extension { #name : #SequenceableCollection }

{ #category : #'*Z3' }
SequenceableCollection >> ensureValidZ3ASTArray [
	self do:[:each | each ensureValidZ3AST ]
]

{ #category : #'*Z3' }
SequenceableCollection >> ensureValidZ3ASTArrayOfKind: kind [
	self do:[:each | each ensureValidZ3ASTOfKind: kind ]
]

{ #category : #'*Z3' }
SequenceableCollection >> ensureValidZ3ObjectArray [
	self do:[:each | each ensureValidZ3Object ]
]
