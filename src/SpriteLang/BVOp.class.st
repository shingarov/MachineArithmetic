Class {
	#name : #BVOp,
	#superclass : #'ΛPrefixOp',
	#instVars : [
		'name',
		'selector',
		'signature'
	],
	#classVars : [
		'BVOps'
	],
	#category : #SpriteLang
}

{ #category : #initialization }
BVOp class >> initialize [
	"
	BVOp initialize
	"
	BVOps := OrderedCollection new.
	{
		'bvadd'	.  #+.     "=>" 'bv{1}' .
		'bvsub'	.  #-.     "=>" 'bv{1}' .
		'bvmul'	.  #*.     "=>" 'bv{1}' .
		'bvdiv'	.  #/.     "=>" 'bv{1}' .
		'bvdivu'.	#udiv:.  "=>" 'bv{1}' .

		'bvshl'.#bitShiftLeft:."=>" 'bv{1}' .
		'bvshrl'.#bitShiftLeft:."=>" 'bv{1}' .
		'bvshra'.#bitShiftLeftArithmetic:."=>" 'bv{1}' .

		'bvand'.#bitAnd:.	"=>" 'bv{1}' .
		'bvor'.#bitOr:.		"=>" 'bv{1}' .
		'bvnot'.#bitInver:."=>" 'bv{1}' .

		'bvlt'.		#<.      "=>" 'bool' .
		'bvle'.		#<=.     "=>" 'bool' .
		'bveq'.		#===.    "=>" 'bool' .
		'bvne'.		#~==.    "=>" 'bool' .
		'bvge'.		#>=.     "=>" 'bool' .
		'bvgt'.		#>.      "=>" 'bool' .
	} tripletsDo: [ :nam :sel :typ |
		TBitVector lengths do:[:len |
			| bvop |

			bvop := BVOp basicNew
							name: (nam , len printString);
							selector: sel;
							signature: (RTypeParser mkTy: (('a:bv{1} => b:bv{1} => ',typ,'[v|v === (a {2} b)]') format: { len . sel} )).
			BVOps add: bvop.
		].
	].
	BVOps sort:[:a :b | a name size > b name size ]

	"
	BVOp initialize
	"

]

{ #category : #syntax }
BVOp class >> parser [
	^PPChoiceParser withAll:
			(BVOps collect:[:bvop | bvop name asParser trim ==> [:ignored | bvop ] ])
]

{ #category : #selfification }
BVOp class >> rTypeSrc [
	self shouldNotImplement
]

{ #category : #'reflect - embedding' }
BVOp class >> smalltalkSelector [
	^self shouldNotImplement
]

{ #category : #accessing }
BVOp >> name [
	^ name
]

{ #category : #initialization }
BVOp >> name: anObject [
	name := anObject
]

{ #category : #printing }
BVOp >> printOn: aStream [
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' ('.
	name printOn: aStream.
	aStream nextPutAll: ')'.
]

{ #category : #selfification }
BVOp >> rType [
	^signature
]

{ #category : #accessing }
BVOp >> selector [
	^ selector
]

{ #category : #initialization }
BVOp >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
BVOp >> signature [
	^ signature
]

{ #category : #initialization }
BVOp >> signature: anObject [
	signature := anObject
]

{ #category : #'reflect - embedding' }
BVOp >> smalltalkSelector [
	^selector
]
