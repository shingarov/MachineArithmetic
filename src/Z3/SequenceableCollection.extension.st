Extension { #name : #SequenceableCollection }

{ #category : #'*Z3' }
SequenceableCollection >> ensureValidZ3ASTArrayInContext: context [ 
	self do:[:each | each ensureValidZ3ASTInContext: context ]
]

{ #category : #'*Z3' }
SequenceableCollection >> ensureValidZ3ASTArrayInContext: context ofKind: kind [
	self do:[:each | each ensureValidZ3ASTInContext: context ofKind: kind ]
]

{ #category : #'*Z3' }
SequenceableCollection >> ensureValidZ3ObjectArray [
	self do:[:each | each ensureValidZ3Object ]
]
