Class {
	#name : #CollectionMiscTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
CollectionMiscTest >> testConcat [
	self
		assert:  {#(1 2 3) . #(4 5 6)} concat
		equals:  #(1 2 3 4 5 6)
]

{ #category : #tests }
CollectionMiscTest >> testConcat0 [
	self
		assert:  OrderedCollection new concat
		equals:  #()
]

{ #category : #tests }
CollectionMiscTest >> testConcat1 [
	self
		assert:  {#(1 2 3)} concat
		equals:  #(1 2 3)
]

{ #category : #tests }
CollectionMiscTest >> testConcatEmptySeparatedBy [
	"Tricky corner case: we can't know the species of the answer from the receiver.
	 Therefore, the programmer must be careful to always pass
	 separator of the correct species."
	self
		assert: ({} separatedBy: '+++')
		equals: ''.
	self
		assert: ({} separatedBy: '')
		equals: ''.
	self
		assert: ({} separatedBy: #())
		equals: #().	

]

{ #category : #tests }
CollectionMiscTest >> testConcatIntersectingSets [
	self
		assert:  {#(1 2 3) asSet . #(3 4 5) asSet} concat
		equals:  #(1 2 3 4 5) asSet
]

{ #category : #tests }
CollectionMiscTest >> testConcatSeparatedBy [
	self
		assert: ({'a'.'b'} separatedBy: '++')
		equals: 'a++b'.
	self
		assert: ({'a'.'b'.'c'} separatedBy: '++')
		equals: 'a++b++c'.

]

{ #category : #tests }
CollectionMiscTest >> testConcatSets [
	self
		assert:  {#(1 2 3) asSet . #(4 5 6) asSet} concat
		equals:  #(1 2 3 4 5 6) asSet
]

{ #category : #tests }
CollectionMiscTest >> testConcatSingleSeparatedBy [
	self
		assert: ({'a'} separatedBy: '++')
		equals: 'a'.

]

{ #category : #tests }
CollectionMiscTest >> testConcatStrings [
	self
		assert:  {'abc' . 'def'} concat
		equals:  'abcdef'
]

{ #category : #tests }
CollectionMiscTest >> testDictionaryInsertIsNonDestructive [
	| d1 d2 |
	d1 := Dictionary new.
	d2 := d1 insert: 'a' at: 1.
	self deny: d1 = d2.
	self assert: d1 isEmpty.
	self deny: d2 isEmpty.
]

{ #category : #tests }
CollectionMiscTest >> testDictionaryInsertOverwrite [
	| d1 d2 |
	d1 := Dictionary newFromAssociations: {1->'a'}.
	d2 := d1 insert: 'b' at: 1.
	self assert: (d1 at: 1) equals: 'a'.
	self assert: (d2 at: 1) equals: 'b'.
]

{ #category : #tests }
CollectionMiscTest >> testDictionarySemigroupPrecedence [
	"In a,b b wins over a."
	| a b |
	a := Dictionary newFromPairs: #(1 a).
	b := Dictionary newFromPairs: #(1 b).
	self
		assert: (a,b at: 1)
		equals: #b
	
	

]

{ #category : #tests }
CollectionMiscTest >> testFoldr1 [
	" foldr (+) 5 [1,2,3,4] >> 15 "
	self
		assert: ( #(1 2 3 4) foldr: [ :a :b | a+b ] fromSeed: 5 )
		equals: 15
]

{ #category : #tests }
CollectionMiscTest >> testFoldr2 [
	" foldr (/) 2 [8,12,24,4] >> 8 "
	self
		assert: ( #(8 12 24 4) foldr: [ :a :b | a/b ] fromSeed: 2 )
		equals: 8
]

{ #category : #tests }
CollectionMiscTest >> testGroupMap [
"
groupMap even [1,2,3]  >>  fromList [(False,[3,1]),(True,[2])]
"
	| collection grouped |
	collection := #(1 2 3).
	grouped := collection groupMap: #even.
	self assert: grouped keys asSet equals: {false . true} asSet.
	self assert: (grouped at: true)  equals: {2}.
	self assert: (grouped at: false) equals: {3 . 1}.
]

{ #category : #tests }
CollectionMiscTest >> testInsertsAbsent [
	| dict1 dict2 |
	dict1 := Dictionary new.
	dict2 := dict1 inserts: 'a' at: 1.
	self assert: (dict2 at: 1) equals: {'a'}.
	self deny: dict1=dict2 "non-destructiveness"
]

{ #category : #tests }
CollectionMiscTest >> testInsertsPresent [
	| dict1 dict2 dict3 |
	dict1 := Dictionary new.
	dict2 := dict1 inserts: 'a' at: 1.
	dict3 := dict2 inserts: 'a' at: 1.
	self assert: (dict3 at: 1) equals: {'a' . 'a'}.
]

{ #category : #tests }
CollectionMiscTest >> testMapAccumL_src1 [
	self
		assert: ( (1 to: 10) mapAccumL: 0 into: [ :a :b | a+b -> a ] )
		equals:  55 -> #(0 1 3 6 10 15 21 28 36 45)
]

{ #category : #tests }
CollectionMiscTest >> testMapAccumL_src2 [
	self
		assert: ( (1 to: 5) mapAccumL: '0' into: [ :a :b | a, b printString -> a ] )
		equals:  '012345' -> #('0' '01' '012' '0123' '01234')
]

{ #category : #tests }
CollectionMiscTest >> testMapAccumL_zvon1 [
	self
		assert: ( #(9 6 3) mapAccumL: 5 into: [ :x :y | x->(x*y) ] )
		equals:  5->#(45 30 15)
]

{ #category : #tests }
CollectionMiscTest >> testMapAccumL_zvon2 [
	self
		assert: ( #(2 4 8) mapAccumL: 5 into: [ :x :y | (x+y)->(x*y) ] )
		equals:  19->#(10 28 88)
]

{ #category : #tests }
CollectionMiscTest >> testMapAccumL_zvon3 [
	self
		assert: ( #(2 4 8) mapAccumL: 5 into: [ :x :y | (x+y)->y ] )
		equals:  19->#(2 4 8)
]

{ #category : #tests }
CollectionMiscTest >> testMapAccumL_zvon4 [
	self
		assert: ( #(2 4 8) mapAccumL: 5 into: [ :x :y | y->y ] )
		equals:  8->#(2 4 8)
]

{ #category : #tests }
CollectionMiscTest >> testMapAccumL_zvon5 [
	self
		assert: ( #(2 4 8) mapAccumL: 5 into: [ :x :y | x->x ] )
		equals:  5->#(5 5 5)
]

{ #category : #tests }
CollectionMiscTest >> testMapEither [
	| collection classifier bs_cs |
	collection := #(1 2 3).
	classifier := [ :j | j even ifTrue: [ Either right: j ] ifFalse: [ Either left: j ] ].
	bs_cs := collection mapEither: classifier.
	self assert: bs_cs key   equals: #(1 3).
	self assert: bs_cs value equals: #(2).
]

{ #category : #tests }
CollectionMiscTest >> testSelectAssociations [
	| d filtered |
	d := Dictionary newFromKeys: #(1 2 3) andValues: #(a a c).
	filtered := d associations selectAssociations: [ :k :v | k odd and: [ v = #a ] ].
	self assert: filtered size equals: 1.
	self assert: filtered first equals: 1->#a.
]

{ #category : #tests }
CollectionMiscTest >> testSplitAt1 [
	self
		assert:  ('Hello world!' splitAt: 6)
		equals:  'Hello ' -> 'world!'
]

{ #category : #tests }
CollectionMiscTest >> testSplitAt2 [
	self
		assert:  ('Hello world!' splitAt: 100)
		equals:  'Hello world!' -> ''
]

{ #category : #tests }
CollectionMiscTest >> testSplitAt3 [
	self
		assert:  (#(1 2 3) splitAt: 1)
		equals:  #(1) -> #(2 3)
]

{ #category : #tests }
CollectionMiscTest >> testSplitAt4 [
	self
		assert:  (#(1 2 3) splitAt: 3)
		equals:  #(1 2 3) -> #()
]

{ #category : #tests }
CollectionMiscTest >> testSplitAt5 [
	self
		assert:  (#(1 2 3) splitAt: 4)
		equals:  #(1 2 3) -> #()
]
