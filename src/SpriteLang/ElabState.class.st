"
type TvSub   = F.SEnv RType
data ElabS   = ElabS { eSub :: !TvSub, eNum :: !Int }
"
Class {
	#name : #ElabState,
	#superclass : #Object,
	#instVars : [
		'eSub',
		'eNum',
		'bvSub'
	],
	#classVars : [
		'current'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
ElabState class >> current [
	current isNil ifTrue: [ current := self basicNew initS0 ].
	^current
]

{ #category : #'instance creation' }
ElabState class >> new [
	^self shouldNotImplement
]

{ #category : #'instance creation' }
ElabState class >> reset [ 
	current := nil
]

{ #category : #'as yet unclassified' }
ElabState class >> runElabM: act [
	self reset.
	^self current runStateT: act
]

{ #category : #accessing }
ElabState >> eSub [
	^eSub
]

{ #category : #'as yet unclassified' }
ElabState >> freshBvId [
	| answer |
	answer := 'bv' intSymbol: eNum.
	eNum := eNum + 1.
	^answer
]

{ #category : #'as yet unclassified' }
ElabState >> freshTVar [
	| answer |
	answer := eNum nonRigidTV.
	eNum := eNum + 1.
	^answer
]

{ #category : #'as yet unclassified' }
ElabState >> initS0 [
	eSub := TvSub new.
	eNum := 0.
	bvSub := BvSub new.
	^self
]

{ #category : #'as yet unclassified' }
ElabState >> runStateT: act [ 
	| v |
	v := act value.
	^{ eSub . v }
]

{ #category : #'as yet unclassified' }
ElabState >> updBvSub: a rtype: t [
	^bvSub := bvSub updBvSub: a rtype: t
]

{ #category : #'as yet unclassified' }
ElabState >> updSub: a rtype: t [
	^eSub := eSub updSub: a rtype: t
]
