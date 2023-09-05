"
A tree for storing strings in which there is one node for every common prefix. The strings (words) are *usually* stored in extra leaf nodes.  The root of a Trie can be recognized by the fact that its caracter instance variable is <nil>.  Words can be determined by the fact that the node completing the word has a nodeValue.  Note that a word does not have to be found at a leaf node (e.g. the word ""in"", see Wipidedia example at link given below).

See <http://en.wikipedia.org/wiki/Trie> for more details.  

Instance Variables: 	
	character	<Character> | <nil >				
	children	<IdentityDictionary> with keys <Character>  and values <Trie>
	nodeValue	<Object>
		
		
Public API:
			
Method 				usage 	
add:value: 				add: aString value: anObject
add:valueWithBlock: 	add: aString valueWithBlock: aBlock
contains: 				contains: aString
containsPrefix: 			containsPrefix: aString
			
For licensing, see class method #license



"
Class {
	#name : #Trie,
	#superclass : #Object,
	#instVars : [
		'character',
		'children',
		'nodeValue'
	],
	#category : #PreSmalltalks-Pharo
}

{ #category : #'instance creation' }
Trie class >> fromList: associations [
"
fromList :: [(Path, a)] -> Trie a
"
	| instance |
	instance := self new.
	associations do: [ :k_v | instance add: k_v key value: k_v value ].
	^instance
]

{ #category : #license }
Trie class >> license [
	"
	Author: Benoit St-Jean
	Email: bstjean@yahoo.com

	MIT license
	"
	
]

{ #category : #'instance creation' }
Trie class >> new [

	^(self basicNew) initialize
]

{ #category : #'should not use' }
Trie class >> new: anObject [

	^self error: 'You should use #new !'
]

{ #category : #private }
Trie class >> newWithCharacter: aCharacter [
	^ self basicNew
		initialize;
		character: aCharacter
]

{ #category : #'instance creation - bulk' }
Trie class >> readFromFile: filename [
	"A utility method that allows to bulk load a file containing one word per line and add them all to a trie structure"

	| aTrie aFile |
	
	aTrie := self new.
	aFile := StandardFileStream readOnlyFileNamed: filename.
	aFile enableReadBuffering.
	[aFile atEnd]
		whileFalse: [| aWord |
					aWord := aFile nextLine.
					aTrie add: aWord value: aWord size].
	aFile close.
	^aTrie 

	
	
]

{ #category : #'example instances' }
Trie class >> wikipediaSampleInstance [
	<sampleInstance>
	"example taken from  <http://en.wikipedia.org/wiki/Trie>"
	| trie |
	trie := Trie new.
	"insert short words then long words"
	trie add: 'to' value: 7.
	trie add: 'tea' value: 3.
	trie add: 'ted' value: 4.
	trie add: 'ten' value: 12.

	"orphan word"
	trie add: 'a' value: 15.

	"insert longer word, then shorter, then in between"
	trie add: 'inn' value: 9.
	trie add: 'i' value: 11.
	trie add: 'in' value: 9.
	^ trie
]

{ #category : #adding }
Trie >> add: aString value: anObject [
	"Add the word <aString> into the Trie structure and set its value to <anObject>"
	|  currentNode |
	
	currentNode := self.
	aString do: [:each | 	|  child  |
						child := currentNode findChildWithLetter: each.
						currentNode := child notNil
											ifTrue: [child ]
											ifFalse: [currentNode addChildWithLetter: each]
							 ].
	currentNode nodeValue: anObject.
	

	
]

{ #category : #adding }
Trie >> add: aString valueWithBlock: aValueBlock [
	"Add the word <aString> into the Trie structure and set its value by evaluating <aValueBlock> with <aString> as parameter.
	
	(Trie new) add: 'abc' valueWithBlock: [:string | string size]
	"

	| currentNode |
	currentNode := self.
	aString
		do: [ :each | 
			| child |
			child := currentNode findChildWithLetter: each.
			currentNode := child notNil
				ifTrue: [ child ]
				ifFalse: [ currentNode addChildWithLetter: each ] ].
	currentNode nodeValue: (aValueBlock value: aString)
]

{ #category : #private }
Trie >> addChildWithLetter: aCharacter [
	| newTrie |
	
	newTrie := self class newWithCharacter: aCharacter.
	self children 
		at: aCharacter 
		put: newTrie.
	^newTrie
]

{ #category : #accessing }
Trie >> character [
	^ character
]

{ #category : #accessing }
Trie >> character: aCharacter [
	character := aCharacter
]

{ #category : #accessing }
Trie >> children [
	^ children
]

{ #category : #accessing }
Trie >> children: anIdentityDictionary [
	children := anIdentityDictionary
]

{ #category : #testing }
Trie >> contains: aString [
	"Answer a <Boolean> telling if the receiver contains the *word* <aString>"

	^(self find: aString) notNil
	

	

	
]

{ #category : #testing }
Trie >> containsPrefix: aString [
	"Answer a <Boolean> telling if the receiver contains  <aString> (either as a prefix or complete word)"

	| currentNode |
	currentNode := self.
	aString
		do: [ :each | 
			| child |
			child := currentNode findChildWithLetter: each.
			child notNil
				ifTrue: [ currentNode := child ]
				ifFalse: [ ^ false ] ].
	^ true 
]

{ #category : #private }
Trie >> find: aString [ 
	"Answers a <Trie> if the word <aString> is found in the receiver, <nil> otherwise"
	|  currentNode |
	
	currentNode := self.
	aString do: [:each | 	| child  |
			
							child := currentNode findChildWithLetter: each.
							child notNil
								ifTrue: [currentNode := child ]
								ifFalse: [^nil]
							 ].
	^currentNode isWord
		ifTrue: [currentNode]
		ifFalse: [nil]

	

	

	
]

{ #category : #private }
Trie >> findChildWithLetter: aCharacter [

	^self children at: aCharacter ifAbsent: [nil]
]

{ #category : #initialization }
Trie >> initialize [
	"Implementation : in test, pre-allocating the dictionary showed worse results than default value"
	children := IdentityDictionary new.

]

{ #category : #testing }
Trie >> isLeaf [

	^self isWord and: [self children isEmpty]
]

{ #category : #testing }
Trie >> isNode [

	^self isRoot not
]

{ #category : #testing }
Trie >> isRoot [

	^self character isNil
]

{ #category : #testing }
Trie >> isWord [

	^self nodeValue notNil
]

{ #category : #accessing }
Trie >> nodeValue [
	^ nodeValue
]

{ #category : #accessing }
Trie >> nodeValue: anObject [
	nodeValue := anObject
]

{ #category : #printing }
Trie >> printOn: aStream [

	super printOn: aStream.
	aStream
		cr;
		nextPutAll: 'children : ';
		nextPutAll: self children keys asSortedCollection asArray printString;
		cr;
		nextPutAll: 'value : ';
		nextPutAll: self nodeValue printString;
		cr;
		nextPutAll: 'leaf : ';
		nextPutAll: self isLeaf printString.
]
