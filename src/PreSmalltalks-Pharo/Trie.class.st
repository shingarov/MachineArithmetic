Class {
	#name : #Trie,
	#superclass : #Object,
	#instVars : [
		'branches'
	],
	#category : #'PreSmalltalks-Pharo'
}

{ #category : #'instance creation' }
Trie class >> empty [
"
empty :: Trie a
"
	^self ofBranches: #()
]

{ #category : #'instance creation' }
Trie class >> fromList: associations [
"
fromList :: [(Path, a)] -> Trie a
"
	^associations inject: self empty into: [ :soFar :eachAss | soFar at: eachAss key insert: eachAss value ]
]

{ #category : #private }
Trie class >> insertKey: i at: is a: v branches: bs [
"
insertKey :: Key -> Path -> a -> [Branch a] -> [Branch a]
"
	bs isEmpty ifTrue: [ ^{ TBBind key: i trie: (self path: is trie: v) } ].
	(bs first isKindOf: TBBind)
		ifTrue: [
			| j tj |
			j := bs first key.
			tj := bs first trie.
			i = j ifTrue: [ ^{TBBind key: i trie: (tj at: is insert: v)},   bs allButFirst ].
			i < j ifTrue: [ ^{TBBind key: i trie: (self path: is trie: v)}, bs ].
		].
	^{bs first}, (self insertKey: i at: is a: v branches: bs allButFirst)
]

{ #category : #'instance creation' }
Trie class >> ofBranches: bs [
	^self basicNew
		branches: bs;
		yourself
]

{ #category : #private }
Trie class >> path: path trie: v [
"
pathTrie :: Path -> a -> Trie a
            path    v
"
	^path isEmpty
		ifTrue: [ self ofBranches: { TBVal of: v } ]
		ifFalse: [ | i is |
			i := path first.
			is := path allButFirst.
			self ofBranches: { TBBind key: i trie: (self path: is trie: v) } ]
]

{ #category : #API }
Trie >> at: path insert: v [
"
insert :: Path -> a -> Trie a -> Trie a
          path    v     self
"
	| i is |
	path isEmpty ifTrue: [ ^self class ofBranches: {TBVal a: v}, branches ].
	i := path first.
	is := path allButFirst.
	^self class ofBranches: (self class insertKey: i at: is a: v branches: branches)
]

{ #category : #accessing }
Trie >> branches [
	^ branches
]

{ #category : #accessing }
Trie >> branches: anObject [
	branches := anObject
]

{ #category : #printing }
Trie >> printOn: aStream [
	aStream nextPutAll: 'Node ['.
	branches
		do: [ :eachBranch | eachBranch printOn: aStream ]
		separatedBy: [ aStream nextPut: $, ].
	aStream nextPut: $]
]
