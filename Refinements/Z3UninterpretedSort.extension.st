Extension { #name : #Z3UninterpretedSort }

{ #category : #'*Refinements' }
Z3UninterpretedSort >> checkEqConstr: f maybeExpr: e tvSubst: θ symbol: a [ 
	self name getString = a ifTrue: [ ^θ ].
	self shouldBeImplemented 
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
Z3UninterpretedSort >> printOn: aStream [
	aStream nextPutAll: self astToString.
	"self name isIntSymbol ifTrue: [ PreSort printGuestInRoom: self name getInt on: aStream ]"
	


]

{ #category : #'*Refinements' }
Z3UninterpretedSort >> sortSubst: θ [
"
sortSubst θ t@(FObj x)    = fromMaybe t (M.lookup x θ)
"
	^θ at: self name getString ifAbsent: [ ^self ]
]
