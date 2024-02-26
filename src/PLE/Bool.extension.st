Extension { #name : #Bool }

{ #category : #'*PLE' }
Bool >> constEEqOrNil [
	"If the receiver is of the form (EEq (EVar x) c), decompose it into x and c.
	 Answer nil if receiver is of any other form."
	| x c |
	self isPAtom ifFalse: [^nil].
	self functorName = '=' ifFalse: [^nil].
	x := self args first.
	c := self args second.
	x isEVar ifFalse: [^nil].
	^x->c
]
