Extension { #name : #ByteArray }

{ #category : #'*MachineArithmetic' }
ByteArray >> asBitVectorBE [
	^(BitVector concatAll: (self asArray "because you can't have a ByteArray of bit vectors"
		collect: [ :aByte | aByte toBitVector: 8])) simplify
]

{ #category : #'*MachineArithmetic' }
ByteArray >> asBitVectorLE [
	^(BitVector concatAll: (self reversed asArray "because you can't have a ByteArray of bit vectors"
		collect: [ :aByte | aByte toBitVector: 8])) simplify
]
