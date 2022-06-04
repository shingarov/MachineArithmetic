Extension { #name : #Set }

{ #category : #'*PreSmalltalks' }
Set >> powerset [
	"It is quite unfortunate that in Smalltalk-80 we can't simply write,
		^self selectM: [ :_ | {true.false} ]
	"
	| some others p1 p2 |
	self isEmpty ifTrue: [ ^Set with: Set new ].
	some := self anyOne.
	others := self without: some.
	p1 := others powerset.
	p2 := p1 collect: [ :each | each union: {some} ].
	^p1 union: p2
]
