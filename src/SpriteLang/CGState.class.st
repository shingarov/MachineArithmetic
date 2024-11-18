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

{ #category : #'state monad' }
CGState class >> current [
	^Context readState: #cgi
]

{ #category : #'instance creation' }
CGState class >> new [
	^self shouldNotImplement
]

{ #category : #'instance creation' }
CGState class >> s0 [
	^self basicNew
		count: 0;
		cgInfo: CGInfo new;
		yourself
]

{ #category : #accessing }
CGState >> cgInfo [
	^ cgInfo
]

{ #category : #accessing }
CGState >> cgInfo: anObject [
	cgInfo := anObject
]

{ #category : #accessing }
CGState >> count [
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
