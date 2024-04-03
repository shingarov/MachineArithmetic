"
SUnit tests for class Trie.

For licensing, see class method #license
"
Class {
	#name : #TrieTest,
	#superclass : #TestCase,
	#instVars : [
		'trie'
	],
	#category : #'PreSmalltalks-Tests'
}

{ #category : #license }
TrieTest class >> license [
	"
	Author: Benoit St-Jean
	Email: bstjean@yahoo.com

	MIT license. 
	"
]

{ #category : #testing }
TrieTest >> test1 [ 
	| t |
	t := Trie fromList: {
		#(1 2)->'A'.
		#(1 2 3 4)->'B'.
		#(1 2 3 5)->'C'.
		#(1 6)->'D'.
	}.
	
]

{ #category : #testing }
TrieTest >> testAddNonString [
	| unTrie |
	unTrie := Trie new.
	unTrie add: 'bon' value: 3.
	self assert: (unTrie contains: 'bon').
	self assert: (unTrie find: 'bon') notNil.
	self assert: (unTrie find: 'bon') nodeValue = 3
]

{ #category : #'tests - adding' }
TrieTest >> testAddValue [
	| aTrie |
	
	aTrie := Trie new.
	aTrie add: 'one' value: 1.
	aTrie add: 'two' value: 2.
	aTrie add: 'fourth' value: '4th'.
	aTrie add: 'four' value: 4.

	self assert: (aTrie find: 'one') notNil.
	self assert: (aTrie contains: 'one').
	self assert: ((aTrie find: 'one') nodeValue = 1).
	
	self assert: (aTrie find: 'two') notNil.
	self assert: (aTrie contains: 'two').
	self assert: ((aTrie find: 'two') nodeValue = 2).
	
	self assert: (aTrie find: 'fourth') notNil.
	self assert: (aTrie contains: 'fourth').
	self assert: ((aTrie find: 'fourth') nodeValue = '4th').
	
	self assert: (aTrie find: 'four') notNil.
	self assert: (aTrie contains: 'four').
	self assert: ((aTrie find: 'four') nodeValue = 4).
	

]

{ #category : #'tests - adding' }
TrieTest >> testAddValueWithBlock [
	| aTrie aBlock |
	
	aBlock := [:string | 	(string = 'one')
							ifTrue: [1]
							ifFalse: [(string = 'two')
										ifTrue: [2]
										ifFalse: [(string = 'fourth')
													ifTrue: ['4th']
													ifFalse: [(string = 'four')
																ifTrue: [4]
																ifFalse: [0]]]]].
	
	aTrie := Trie new.
	aTrie add: 'one' valueWithBlock: aBlock.
	aTrie add: 'two' valueWithBlock: aBlock.
	aTrie add: 'fourth' valueWithBlock: aBlock.
	aTrie add: 'four' valueWithBlock: aBlock.

	self assert: (aTrie find: 'one') notNil.
	self assert: (aTrie contains: 'one').
	self assert: ((aTrie find: 'one') nodeValue = 1).
	
	self assert: (aTrie find: 'two') notNil.
	self assert: (aTrie contains: 'two').
	self assert: ((aTrie find: 'two') nodeValue = 2).
	
	self assert: (aTrie find: 'fourth') notNil.
	self assert: (aTrie contains: 'fourth').
	self assert: ((aTrie find: 'fourth') nodeValue = '4th').
	
	self assert: (aTrie find: 'four') notNil.
	self assert: (aTrie contains: 'four').
	self assert: ((aTrie find: 'four') nodeValue = 4).
]

{ #category : #testing }
TrieTest >> testAddWord [
	| unTrie |
	unTrie := Trie new.
	unTrie add: 'bon' value: 3.
	self assert: (unTrie contains: 'bon').
	self assert: (unTrie find: 'bon') notNil.
	self assert: (unTrie find: 'bon') nodeValue = 3
]

{ #category : #'tests - testing' }
TrieTest >> testAnEmptyTrieDoesNotContainPrefix [

	self deny: (Trie new containsPrefix: 'z').

	
]

{ #category : #'tests - testing' }
TrieTest >> testContains [
	| aTrie |
	aTrie := Trie new.
	self deny: (aTrie contains: 'z').

	"now, back to our wikipedia example"
	self deny: (trie contains: 'z').
	self deny: (trie contains: 't').
	self assert: (trie contains: 'to').
	self deny: (trie contains: 'toz').
	self deny: (trie contains: 'te').
	self assert: (trie contains: 'tea').
	self assert: (trie contains: 'ted').
	self assert: (trie contains: 'ten').
	self deny: (trie contains: 'tez').
	self deny: (trie contains: 'teaz').
	self deny: (trie contains: 'tedz').
	self deny: (trie contains: 'tenz').
	self assert: (trie contains: 'a').
	self deny: (trie contains: 'az').
	self assert: (trie contains: 'i').
	self assert: (trie contains: 'in').
	self assert: (trie contains: 'inn').
	self deny: (trie contains: 'iz').
	self deny: (trie contains: 'inz').
	self deny: (trie contains: 'innz')
]

{ #category : #'tests - testing' }
TrieTest >> testContainsPrefix [

	self deny: (trie containsPrefix: 'z').
	self assert: (trie containsPrefix: 't').
	self assert: (trie containsPrefix: 'to').
	self deny: (trie containsPrefix: 'toz').
	self assert: (trie containsPrefix: 'te').
	self assert: (trie containsPrefix: 'tea').
	self assert: (trie containsPrefix: 'ted').
	self assert: (trie containsPrefix: 'ten').
	self deny: (trie containsPrefix: 'tez').
	self deny: (trie containsPrefix: 'teaz').
	self deny: (trie containsPrefix: 'tedz').
	self deny: (trie containsPrefix: 'tenz').
	self assert: (trie containsPrefix: 'a').
	self deny: (trie containsPrefix: 'az').
	self assert: (trie containsPrefix: 'i').
	self assert: (trie containsPrefix: 'in').
	self assert: (trie containsPrefix: 'inn').
	self deny: (trie containsPrefix: 'iz').
	self deny: (trie containsPrefix: 'inz').
	self deny: (trie containsPrefix: 'innz')
]

{ #category : #'tests - testing' }
TrieTest >> testIsLeaf [
	| aTrie aWord aLongerWord aNode |
	aTrie := Trie new.
	self deny: aTrie isLeaf.

	"Just add a node with a private method"
	aNode := aTrie addChildWithLetter: $r.
	self deny: aNode isLeaf.
	aTrie add: 'rush' value: 2112.
	aWord := aTrie find: 'rush'.
	self assert: aWord isLeaf.
	self deny: aTrie isLeaf.

	"Add a longer word with rush as prefix so rush is no longer a leaf"
	aTrie add: 'rushed' value: 1.
	aWord := aTrie find: 'rush'.
	self deny: aWord isLeaf.
	aLongerWord := aTrie find: 'rushed'.
	self assert: aLongerWord isLeaf.

	
]

{ #category : #'tests - testing' }
TrieTest >> testIsLeafWikipediaExample [

	self assert: (trie find: 'to') isLeaf.
	self assert: (trie find: 'tea') isLeaf.
	self assert: (trie find: 'ted') isLeaf.
	self assert: (trie find: 'ten') isLeaf.
	self assert: (trie find: 'a') isLeaf.
	self deny: (trie find: 'i') isLeaf.
	self assert: (trie find: 'inn') isLeaf.
	self deny: (trie find: 'in') isLeaf
]

{ #category : #'tests - testing' }
TrieTest >> testIsNode [
	| aTrie aWord aLongerWord aNode |
	
	aTrie := Trie new.
	self deny: aTrie isNode.
	
	"Just add a node with a private method"
	aNode := aTrie addChildWithLetter: $r.
	self assert: aNode isNode.	
	
	aTrie add: 'rush' value: 2112.
	aWord := aTrie find: 'rush'.
	
	self assert: aWord isNode.
	self deny: aTrie isNode.
	
	"Add a longer word with rush as prefix so rush is no longer a leaf"	
	aTrie add: 'rushed' value: 1.

	aWord := aTrie find: 'rush'.
	self assert: aWord isNode.
	aLongerWord := aTrie find: 'rushed'.
	self assert: aLongerWord isNode.
	
	"now, back to our wikipedia example"
	self assert: (trie find: 'to') isNode.
	self assert: (trie find: 'tea') isNode.
	self assert: (trie find: 'ted') isNode.
	self assert: (trie find: 'ten') isNode.
	self assert: (trie find: 'a') isNode.
	self assert: (trie find: 'i') isNode.	
	self assert: (trie find: 'inn') isNode.
	self assert: (trie find: 'in') isNode.
	self deny: trie isNode


	
	
	
]

{ #category : #'tests - testing' }
TrieTest >> testIsRoot [
	| aTrie aWord aLongerWord aNode |
	
	aTrie := Trie new.
	self assert: aTrie isRoot.
	
	"Just add a node with a private method"
	aNode := aTrie addChildWithLetter: $r.
	self deny: aNode isRoot.	
	
	aTrie add: 'rush' value: 2112.
	aWord := aTrie find: 'rush'.
	
	self deny: aWord isRoot.
	self assert: aTrie isRoot.
	
	"Add a longer word with rush as prefix so rush is no longer a leaf"	
	aTrie add: 'rushed' value: 1.

	aWord := aTrie find: 'rush'.
	self deny: aWord isRoot.
	aLongerWord := aTrie find: 'rushed'.
	self deny: aLongerWord isRoot.
	
	"now, back to our wikipedia example"
	self deny: (trie find: 'to') isRoot.
	self deny: (trie find: 'tea') isRoot.
	self deny: (trie find: 'ted') isRoot.
	self deny: (trie find: 'ten') isRoot.
	self deny: (trie find: 'a') isRoot.
	self deny: (trie find: 'i') isRoot.	
	self deny: (trie find: 'inn') isRoot.
	self deny: (trie find: 'in') isRoot.
	self assert: trie isRoot


	
	
	
]

{ #category : #'tests - testing' }
TrieTest >> testIsWord [
	| aTrie aWord aLongerWord aNode |
	aTrie := Trie new.
	self deny: aTrie isWord.

	"Just add a node with a private method"
	aNode := aTrie addChildWithLetter: $r.
	self deny: aNode isWord.
	aTrie add: 'rush' value: 2112.
	aWord := aTrie find: 'rush'.
	self assert: aWord isWord.
	self deny: aTrie isWord.

	"Add a longer word with rush as prefix so rush is no longer a leaf"
	aTrie add: 'rushed' value: 1.
	aWord := aTrie find: 'rush'.
	self assert: aWord isWord.
	aLongerWord := aTrie find: 'rushed'.
	self assert: aLongerWord isWord.

	
]

{ #category : #'tests - testing' }
TrieTest >> testIsWordWikipediaExample [

	self assert: (trie find: 'to') isWord.
	self assert: (trie find: 'tea') isWord.
	self assert: (trie find: 'ted') isWord.
	self assert: (trie find: 'ten') isWord.
	self assert: (trie find: 'a') isWord.
	self assert: (trie find: 'i') isWord.
	self assert: (trie find: 'inn') isWord.
	self assert: (trie find: 'in') isWord
]
