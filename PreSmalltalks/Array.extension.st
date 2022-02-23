Extension { #name : #Array }

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
