Extension { #name : #Z3UninterpretedSort }

{ #category : #'*Refinements' }
Z3UninterpretedSort >> checkEqConstr: f maybeExpr: e tvSubst: θ symbol: a [ 
	self name getString = a ifTrue: [ ^θ ].
	self shouldBeImplemented 
]

{ #category : #'*Refinements' }
Z3UninterpretedSort >> isMono [
	^false
]

{ #category : #'*Refinements' }
Z3UninterpretedSort >> printInstantiatorOn: aStream [
	"Smalltalk at: #TheTypeHotel put: Hotel new.
	TheTypeHotel roomFor: (FApp s: 'a' toSort t: 'b' toSort)
	"
	| fapp |
	fapp := TheTypeHotel at: self name getString allButFirst allButFirst asInteger.
	aStream nextPut: (Character codePoint: 16r2301).
	aStream nextPut: $(.
	aStream nextPutAll: fapp s name getString.
	aStream space.
	aStream nextPutAll: fapp t name getString.
	aStream nextPut: $).
]

{ #category : #'*Refinements' }
Z3UninterpretedSort >> printOn: aStream [
	aStream nextPutAll: self astToString.
	self name isIntSymbol ifTrue: [ PreSort printGuestInRoom: self name getInt on: aStream ]
	


]

{ #category : #'*Refinements' }
Z3UninterpretedSort >> sortSubst: θ [
"
sortSubst θ t@(FObj x)    = fromMaybe t (M.lookup x θ)
"
	^θ at: self name getString ifAbsent: [ ^self ]
]
