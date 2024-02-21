Class {
	#name : #TBBind,
	#superclass : #TrieBranch,
	#instVars : [
		'key',
		'trie'
	],
	#category : #'PreSmalltalks-Pharo'
}

{ #category : #'as yet unclassified' }
TBBind class >> key: key trie: trie [
	^self basicNew
		key: key;
		trie: trie;
		yourself
]

{ #category : #accessing }
TBBind >> key [
	^ key
]

{ #category : #accessing }
TBBind >> key: anObject [
	anObject isInteger ifFalse: [ self error ].
	key := anObject
]

{ #category : #printing }
TBBind >> printOn: aStream [
	aStream nextPutAll: 'Bind '.
	key printOn: aStream.
	aStream nextPutAll: ' ('.
	trie printOn: aStream.
	aStream nextPut: $)
]

{ #category : #accessing }
TBBind >> trie [
	^ trie
]

{ #category : #accessing }
TBBind >> trie: anObject [
	(anObject isKindOf: Trie) ifFalse: [ self error ].
	trie := anObject
]
