Extension { #name : #Bool }

{ #category : #'*PLE' }
Bool >> constEEqOrNil [
	| x c |
	self isPAtom ifFalse: [^nil].
	self functorName = '=' ifFalse: [^nil].
	x := self args first.
	c := self args second.
	x isEVar ifFalse: [^nil].
	^x->c
]
