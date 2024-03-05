Class {
	#name : #TBitVector,
	#superclass : #'ΛBase',
	#instVars : [
		'length'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
TBitVector class >> instance: length [
	^self basicNew length: length

]

{ #category : #accessing }
TBitVector class >> lengths [
	"Return supported bitvector lengths.

	WARNING: If you change this, you MUST evaluate

		BVOp initialize

	!!!
	"

	^#(8 16 32 64)
]

{ #category : #accessing }
TBitVector class >> prelude [
	| sigs |

	sigs := OrderedCollection new.
	{
		'bvadd'	.  #+.     "=>" 'bv{1}' .
		'bvsub'	.  #-.     "=>" 'bv{1}' .
		'bvmul'	.  #*.     "=>" 'bv{1}' .
		'bvdiv'	.  #/.     "=>" 'bv{1}' .

		'bvdivu'.	#udiv:.  "=>" 'bv{1}' .

		'bvlt'.		#<.      "=>" 'bool' .
		'bvle'.		#<=.     "=>" 'bool' .
		'bveq'.		#===.    "=>" 'bool' .
		'bvne'.		#~==.    "=>" 'bool' .
		'bvge'.		#>=.     "=>" 'bool' .
		'bvgt'.		#>.      "=>" 'bool' .
	} tripletsDo: [ :nam :sel :typ |
		self lengths do:[:len |
			| sig |

			sig := (nam , len printString)
							-> (RTypeParser mkTy: (('a:bv{1} => b:bv{1} => ',typ,'[v|v === (a {2} b)]') format: { len . sel} )).
			sigs add: sig.
		].
	].

	"^sigs"
	^#()

	"
	TBitVector prelude
	"
]

{ #category : #comparing }
TBitVector >> = another [
	^self class = another class
		and:[length = another length]
]

{ #category : #'as yet unclassified' }
TBitVector >> baseSort [
	^ Z3Sort bv: length
]

{ #category : #comparing }
TBitVector >> hash [
	^(self class hash + length) hashMultiply
]

{ #category : #testing }
TBitVector >> isBitVector [
	^true
]

{ #category : #accessing }
TBitVector >> length [
	^ length
]

{ #category : #initialization }
TBitVector >> length: anInteger [
	self assert: anInteger isInteger.
	self assert: anInteger >= 0.
	self assert: length isNil.

	length := anInteger
]

{ #category : #printing }
TBitVector >> printOn: aStream [
	aStream nextPutAll: 'TBitVector['.
	length printOn: aStream.
	aStream nextPut: $].

]

{ #category : #'α-renaming' }
TBitVector >> uniq2: α [
	"Nothing to do"
]
