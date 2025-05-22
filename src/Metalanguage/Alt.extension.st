Extension { #name : #Alt }

{ #category : #'*Metalanguage' }
Alt >> toANF [
	^Alt daCon: daCon binds: binds expr: expr toANF
]

{ #category : #'*Metalanguage' }
Alt >> toMIF [
	^Alt daCon: daCon binds: binds expr: expr toMIF
]
