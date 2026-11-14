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
		'typeLevelConstraints'
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

{ #category : #'bv size resolution' }
ElabState >> addTypeLevelConstraint: c [
	self typeLevelConstraints add: c
]

{ #category : #accessing }
ElabState >> eSub [
	^eSub
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
	^self
]

{ #category : #'as yet unclassified' }
ElabState >> instantiateTypeLevelConstraints [
	| bli |
	[ bli := BvLengthInference current ] on: NoAnswer do: [^self].
	"First, instantiate whatever FVs are still hanging, to unknown-sizes."
	((eSub values >>= #freeTVars) asSet select: #nonRigid) do: [ :fv |
		| tc t |
		tc := FTyconUnknownBitVecSize length: ('ßßBitVectorSize_', fv) toInt.
		t := (FTC new: tc) sort2bTrue.
		eSub at: fv put: t
	].
	eSub := eSub subsTy: eSub.
	"Next, substritute the FVs in the TL-constraints."
	typeLevelConstraints := self typeLevelConstraints collect: [ :eachTLC | eachTLC subsTy: eSub ].
	"Finally, compute the Z3 constraints and add them to the BvLengthInference monad."
	typeLevelConstraints do: [ :eachTLC | eachTLC addTo: bli ]
]

{ #category : #'bv size resolution' }
ElabState >> resolveBvLengthsIn: aBvLengthInference [

	| resolvedLengths vis |
self halt.
	resolvedLengths := aBvLengthInference
		resolveIfUnsat: [ Incompatible signal ]
		ifAmbiguous: [ self shouldBeImplemented ].
	vis := Visitor defaultTransforming: [ :x |
		(x isKindOf: FTyconUnknownBitVecSize)
			ifTrue: [ x resolveIn: resolvedLengths ] ifFalse: [ x ] ].
	^self accept: vis



	"| model |
	self typeLevelConstraints do: [ :c | c addConstraintTo: bv ].
	model := bv
		resolveIfUnsat: [ Incompatible signal ]
		ifAmbiguous: [ self shouldBeImplemented ]."
	"model keysAndValuesDo: [ :k :v | self interpretBvLengthKey: k value: v ]"
	"eSub at: 'fvºº0' put: (FTC new: (FTyconBitVecSize length: 8) ) sort2bTrue" "BOGUS, should copy refinement"
]

{ #category : #'as yet unclassified' }
ElabState >> runStateT: act [ 
	| v |
	v := act value.
	self instantiateTypeLevelConstraints.
	^{ eSub . v }
]

{ #category : #'bv size resolution' }
ElabState >> typeLevelConstraints [
	typeLevelConstraints isNil ifTrue: [ typeLevelConstraints := OrderedCollection new ].
	^typeLevelConstraints
]

{ #category : #'as yet unclassified' }
ElabState >> updSub: a rtype: t [
	^eSub := eSub updSub: a rtype: t
]
