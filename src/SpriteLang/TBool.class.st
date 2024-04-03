Class {
	#name : #TBool,
	#superclass : #'ΛBase',
	#classInstVars : [
		'instance'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
TBool class >> instance [ 
	instance isNil ifTrue: [ instance := self basicNew ].
	^instance
]

{ #category : #'as yet unclassified' }
TBool >> baseSort [
	^Bool sort
]

{ #category : #printing }
TBool >> printOn: aStream [
	aStream nextPutAll: 'TBool'
]

{ #category : #'α-renaming' }
TBool >> uniq2: α [
	"Nothing to do"
]
