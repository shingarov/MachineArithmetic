Extension { #name : #Z3UninterpretedSort }

{ #category : #'*Refinements' }
Z3UninterpretedSort >> checkEqConstr: f maybeExpr: e tvSubst: θ symbol: a [ 
	self name getString = a ifTrue: [ ^θ ].
	self shouldBeImplemented 
]

{ #category : #'*Refinements' }
Z3UninterpretedSort >> checkNumeric: env tvSubst: θ [
	"In Smalltalk I need to be actually unified,
	 because 'a is a type variable."
	| γ |
	γ := Context currentElabEnv.
	γ senv sort note: self elaboratedTo: Int sort.
	^θ updateVar: self _: Int sort
]

{ #category : #'*Refinements' }
Z3UninterpretedSort >> containsFVar [
	^true
]

{ #category : #'*Refinements' }
Z3UninterpretedSort >> functionSort [
	^nil "functionSort $ FObj (symbol 'a') >> Nothing"
]

{ #category : #'*Refinements' }
Z3UninterpretedSort >> guest [
	self name isIntSymbol ifFalse: [ ^nil ].
	^PreSort guestInRoom: self name getInt
	


]

{ #category : #'*Refinements' }
Z3UninterpretedSort >> isMono [
	^false
]

{ #category : #'*Refinements' }
Z3UninterpretedSort >> printStringInHotel: h [
	self name isIntSymbol ifTrue: [
		| guest |
		guest := h at: self name getInt ifAbsent: [ ^self printString, ' ?!' ].
		^self printString, ' : ', guest printString
	] ifFalse: [
		^self printString
	]
]

{ #category : #'*Refinements' }
Z3UninterpretedSort >> sortSubst: θ [
"
sortSubst θ t@(FObj x)    = fromMaybe t (M.lookup x θ)
"
	^θ at: self ifAbsent: [
		"In Smalltalk this is a bit more complex.
		 The problem is that something like k!1 may stand for (list 'a),
		 and now let's say we are substing 'a with ℤ.
		 Then I have to go back to the PreSort, subst in there,
		 and re-settle the new guest in the hotel."
		| guest newGuest |
		guest := self guest.
		guest isNil ifTrue: [ ^self ].
		newGuest := guest sortSubst: θ.
		^newGuest z3sort
	]
]
