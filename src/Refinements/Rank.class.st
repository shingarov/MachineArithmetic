"
scc  :: !Int    -- ^ SCC number with ALL dependencies
icc  :: !Int    -- ^ SCC number without CUT dependencies
tag  :: !F.Tag  -- ^ The constraint's Tag
"
Class {
	#name : #Rank,
	#superclass : #Object,
	#instVars : [
		'scc',
		'icc',
		'tag'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Rank class >> new [
	self shouldNotImplement 
]

{ #category : #'instance creation' }
Rank class >> scc: scc icc: icc tag: tag [
	^self basicNew scc: scc; icc: icc; tag: tag; yourself 
]

{ #category : #accessing }
Rank >> icc [
	^ icc
]

{ #category : #accessing }
Rank >> icc: anObject [
	icc := anObject
]

{ #category : #printing }
Rank >> printOn: aStream [
	scc printOn: aStream.
	aStream nextPut: (Character codePoint: 16r227B).
	icc printOn: aStream.
	tag isNil ifFalse: [ 
		aStream nextPutAll: ' ! '.
		tag printOn: aStream ]

]

{ #category : #accessing }
Rank >> scc [
	^ scc
]

{ #category : #accessing }
Rank >> scc: anObject [
	scc := anObject
]

{ #category : #accessing }
Rank >> tag [
	^ tag
]

{ #category : #accessing }
Rank >> tag: anObject [
	tag := anObject
]
