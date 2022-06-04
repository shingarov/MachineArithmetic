Extension { #name : #Array }

{ #category : #'*PreSmalltalks' }
Array >> allCombinations [
	"Assuming I am a collection of Cartesian 'dimensions',
	 each dimension being a finite collection of possible values along that dimension,
	 answer the collection of all constituent points of the space I represent.
	
	#( (1 2)  (3 4) ) allCombinations >>> #( (1 3) (1 4) (2 3) (2 4) )
	"
	| x xs ys |
	self isEmpty ifTrue: [ ^{#()} ].
	self first isEmpty ifTrue: [ ^#() ].
	x  := self first first.
	xs := self first allButFirst.
	ys := self allButFirst.
	^(ys allCombinations collect: [ :each | {x}, each ]),
	  ({xs}, ys) allCombinations
]

{ #category : #'*PreSmalltalks' }
Array >> unzip: n [
	| braids |
	braids := Array new: n.
	1 to: n do: [ :j | braids at: j put: OrderedCollection new ].
	
	self do: [ :a |
		a size = n ifFalse: [ self error ].
		1 to: n do: [ :j | (braids at: j) addLast: (a at: j) ] ].
	^braids
]
