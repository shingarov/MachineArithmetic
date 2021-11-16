Extension { #name : #Association }

{ #category : #'*MachineArithmetic' }
Association >> cubeSolIfEmpty: aBlock [
	| b bs eqs |
	self key size = 0 ifTrue: [ ^aBlock value ].
	b := self key first.
	bs := self key allButFirst.
	eqs := self value.
	^CstrAll bind: b p: (bs->eqs cubeSolIfEmpty: aBlock)
]
