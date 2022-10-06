"
I am a brain-damaged function-application Sort which is not a Z3Sort.
Cf. Sorts.hs:
data Sort =
  ...
  | FApp  !Sort !Sort    -- ^ constructed type
"
Class {
	#name : #FApp,
	#superclass : #Object,
	#instVars : [
		's',
		't'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FApp class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
FApp class >> s: aSort t: anotherSort [
	^self basicNew
		s: aSort;
		t: anotherSort;
		yourself
]

{ #category : #printing }
FApp >> printOn: aStream [
	aStream nextPutAll: '(FApp '.
	s printOn: aStream.
	aStream space.
	t printOn: aStream.
	aStream nextPutAll: ')'.
]

{ #category : #accessing }
FApp >> s [
	^ s
]

{ #category : #accessing }
FApp >> s: anObject [
	s := anObject
]

{ #category : #accessing }
FApp >> t [
	^ t
]

{ #category : #accessing }
FApp >> t: anObject [
	t := anObject
]
