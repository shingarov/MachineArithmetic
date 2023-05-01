"
data CGState = CGState
  { cgCount :: !Integer             -- ^ monotonic counter, to get fresh things
  , cgInfo  :: !CGInfo              -- ^ extra bits needed for constraints
  }
"
Class {
	#name : #CGState,
	#superclass : #Object,
	#instVars : [
		'count',
		'cgInfo'
	],
	#classVars : [
		'current'
	],
	#category : #'SpriteLang-CgMonad'
}

{ #category : #initialization }
CGState class >> current [
	current isNil ifTrue: [ current := self basicNew ].
	^current
]

{ #category : #initialization }
CGState class >> new [
	^self shouldNotImplement
]

{ #category : #initialization }
CGState class >> reset [ 
	current := nil
]

{ #category : #accessing }
CGState >> cgInfo [
	cgInfo isNil ifTrue: [ cgInfo := CGInfo new ].
	^ cgInfo
]

{ #category : #accessing }
CGState >> cgInfo: anObject [
	cgInfo := anObject
]

{ #category : #accessing }
CGState >> count [
	count isNil ifTrue: [ count := 0 ].
	^ count
]

{ #category : #accessing }
CGState >> count: anObject [
	count := anObject
]

{ #category : #generating }
CGState >> freshInt [
	| n |
	n := self count.
	self count: n+1.
	^n
]

{ #category : #generating }
CGState >> freshValueSym [
	^self freshInt vv
]
