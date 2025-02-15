Extension { #name : #MessageSend }

{ #category : #'*Refinements' }
MessageSend >> accept: aVisitor [
	^self class
		receiver: (receiver accept: aVisitor)
		selector: selector
		arguments: (arguments collect: [ :eachArg | eachArg accept: aVisitor ])
]

{ #category : #'*Refinements' }
MessageSend >> checkExpr: f [ 
	"This is bogus ad-hoc hackery,
	 but it will serve for today's experiment."
	
	" binary operators: 'a → 'a →'a "
	selector ∈ #(∪ ∩ + - * / bitOr:) ifTrue: [ ^f checkOp: selector e₁: receiver e₂: arguments first ].
	
	" special Set theory selector #add: "
	selector = #add: ifTrue: [
		| setT formalElemT actualElemT s |
		setT := receiver checkExpr: f.
		setT s typeConstructor symbol = 'Set_Set' ifFalse: [ self error: '#add: sent to non-Set' ].
		formalElemT := setT t.
		arguments size = 1 ifFalse: [ self error ].
		actualElemT := arguments first checkExpr: f.
		s := f unify: nil sort: formalElemT sort: actualElemT.
		s isEmpty ifFalse: [ self shouldBeImplemented ].
		^setT
	].
	
	self shouldBeImplemented
]

{ #category : #'*Refinements' }
MessageSend >> elab: anElabEnv [
	| computed |
	computed := (receiver elab: anElabEnv) first
		perform: self selector
		withArguments: (arguments collect: [ :eachArg | (eachArg elab: anElabEnv) first ]).
	^{ computed . computed sort }
]

{ #category : #'*Refinements' }
MessageSend >> elabApply: γ [
	^MessageSend
		receiver: (self receiver elabApply: γ)
		selector: self selector
		arguments: (self arguments collect: [ :eachArg | eachArg elabApply: γ ])
]

{ #category : #'*Refinements' }
MessageSend >> elabApplyStep: γ [
	^MessageSend
		receiver: (self receiver elabApply: γ)
		selector: self selector
		arguments: (self arguments collect: [ :eachArg | eachArg elabApplyStep: γ ] )
]

{ #category : #'*Refinements' }
MessageSend >> evaluateIn: anEvalEnv ifUndeclared: vndBlock [
	^(self receiver evaluateIn: anEvalEnv ifUndeclared: vndBlock)
		perform: self selector
		withArguments: (arguments collect: [ :a | a evaluateIn: anEvalEnv ifUndeclared: vndBlock ])
]
