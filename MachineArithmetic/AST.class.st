"
In Z3, expressions, sorts and declarations are called ASTs. ASTs are directed acyclic graphs. Every expression has a sort. Send #sort to get the sort of an expression.

When we get an AST handle from Z3, we look at the sort, and create an instance of the concrete subclass (BitVector, Bool etc) appropriate for the sort.

In addition to sorts, ASTs also have kinds: VAR, NUMERAL, APP etc.  This becomes tricky because in Smalltalk this would correspond to something like a two-dimensional class membership, which we don't have.  So to send messages understood by AST of particular kinds (e.g. arity is a concept specific to function applications), we can downcast an AST to its kind by sending #asKind, and back by sending #asAST.
"
Class {
	#name : #AST,
	#superclass : #Z3ContextedObject,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'particular sort creation' }
AST class >> mkConst: aSymbol ofSort: aSort [
	| ptr |
	ptr := LibZ3 uniqueInstance
		mkConst: aSort ctx
		symbol: aSymbol
		sort: aSort.
	^AST wrap: ptr in: aSort ctx
]

{ #category : #'particular sort creation' }
AST class >> numeral: aString ofSort: ty [
	| ptr |
	ptr := LibZ3 uniqueInstance
		mkNumeral: ty ctx
		numeral: aString
		type: ty.
	^AST wrap: ptr in: ty ctx
]

{ #category : #'particular sort creation' }
AST class >> var: varName ofSort: ty [
	| sym |
	sym := Z3Symbol from: varName on: ty ctx.
	^self mkConst: sym ofSort: ty
]

{ #category : #'instance creation' }
AST class >> wrap: aPointer in: aZ3Context [
	"Create a Smalltalk object of the correct AST-subclass
	wrapping around the given pointer to the native Z3-land."
	| sort concreteSubclass |
	aPointer isNull ifTrue: [ ^nil ].
	sort := (LibZ3 uniqueInstance getSort: aZ3Context astHandle: aPointer)
		ctx: aZ3Context.
	concreteSubclass := sort getASTClass.
	^concreteSubclass ctx: aZ3Context handle: aPointer
]

{ #category : #comparing }
AST >> = another [
	^self hash = another hash
]

{ #category : #adapting }
AST >> adaptToInteger: x andSend: selector [ 
	^(self coerce: x) perform: selector with: self
]

{ #category : #adapting }
AST >> adaptToNumber: x andSend: selector [ 
	self shouldBeImplemented.
]

{ #category : #printing }
AST >> astToString [
	^LibZ3 uniqueInstance astToString: self ctx ast: self
]

{ #category : #adapting }
AST >> beLikeMe: value [
	"Convert and return value to value of receiver's sort"
	self subclassResponsibility 
]

{ #category : #adapting }
AST >> coerce: value [
	"Convert value to be of the same sort as receiver and return it"
	
	(value isAST and:[value sort getASTClass == self class]) ifTrue:[ ^ value ].
	^self beLikeMe: value.
]

{ #category : #access }
AST >> elementOfModel: aZ3Model [
	| funcDecl |
	self term isConstant ifFalse: [ self shouldBeImplemented ].
	^aZ3Model getInterp: self term funcDecl 
	
	
]

{ #category : #'double dispatching' }
AST >> differenceFromInteger:anInteger [
	"`anInteger` does not know how to subtract the receiver 
	 (a kind of AST). Coerce `anInteger` and retry.

	 St/X specific.
	"

	^ (self coerce: anInteger) - self

	"Modified: / 09-09-2020 / 11:28:43 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #operations }
AST >> eq: rhs [
	^(LibZ3 uniqueInstance mkEq: ctx l: self r: (self coerce: rhs))
		ctx: ctx
]

{ #category : #'double dispatching' }
AST >> equalFromInteger:anInteger [
	"`anInteger` does not know how to compare with the receiver 
	 (a kind of AST). Coerce `anInteger` and retry.

	 St/X specific.
	"

	^ (self coerce: anInteger) = self

	"Modified (comment): / 09-09-2020 / 11:31:31 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #typing }
AST >> getKindCode [
	^LibZ3 uniqueInstance getAstKind: ctx ast: self
]

{ #category : #access }
AST >> getNumeralString [
	^LibZ3 uniqueInstance getNumeralString: ctx ast: self
]

{ #category : #comparing }
AST >> hash [
	^LibZ3 uniqueInstance getAstHash: ctx ast: self simplify
]

{ #category : #'term rewriting' }
AST >> inEnvironment: aDictionary [
	| from to vars |
	aDictionary isEmpty ifTrue: [ ^self ].
	vars := self variables.
	from := aDictionary keys asArray.
	to := from collect: [ :k | aDictionary at: k ].
	"now make sure everything is a Z3 object"
	from := from collect: [ :k | k isAST
		ifTrue: [ k ]
		ifFalse: [ self variableNamed: k ]].
	1 to: from size do: [ :i | to at: i
		put: ((from at: i) isNil ifTrue: [ nil ] ifFalse: [ (from at: i) coerce: (to at: i) ])].
	^(self substituteAll: from withoutNils with: to withoutNils) simplify
]

{ #category : #'term rewriting' }
AST >> inThisEnvironment [
	| senderContext senderEnvironment |
	senderContext := thisContext sender.
	senderEnvironment := Dictionary new: senderContext size + 1"self".
	senderContext tempNames withIndexDo:[:n :i |
		senderEnvironment at: n put: (senderContext at: i)
	].
	senderEnvironment at: 'self' put: senderContext receiver.
	^ self inEnvironment: senderEnvironment
]

{ #category : #testing }
AST >> isAST [
	^true
]

{ #category : #testing }
AST >> isAsArray [
	^LibZ3 uniqueInstance isAsArray: ctx ast: self
]

{ #category : #testing }
AST >> isBitVector [
	^self sort getASTClass == BitVector
]

{ #category : #testing }
AST >> isExists [
	self shouldBeImplemented 
]

{ #category : #testing }
AST >> isForAll [
	self shouldBeImplemented 
]

{ #category : #testing }
AST >> isLambda [
	self shouldBeImplemented 
]

{ #category : #testing }
AST >> isNumeral [
	^LibZ3 uniqueInstance isNumeral: ctx ast: self
]

{ #category : #testing }
AST >> isSymbolic [
	^self isNumeral not
]

{ #category : #typing }
AST >> kindClass [
	^ASTKind of: self
]

{ #category : #'double dispatching' }
AST >> lessFromInteger:anInteger [
	"`anInteger` does not know how to compare with the receiver 
	 (a kind of AST). Coerce `anInteger` and retry.

	 St/X specific.
	"

	^ (self coerce: anInteger) < self

	"Modified: / 09-09-2020 / 11:31:19 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #printing }
AST >> printOn: aStream [
	self kindClass printAST: self on: aStream
]

{ #category : #'double dispatching' }
AST >> productFromInteger:anInteger [
	"`anInteger` does not know how to multiply itself with the receiver 
	 (a kind of AST). Coerce `anInteger` and retry.

	 St/X specific.
	"

	^ (self coerce: anInteger) * self

	"Modified: / 09-09-2020 / 11:27:27 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #operations }
AST >> simplify [
	^AST wrap: (LibZ3 uniqueInstance simplify: ctx ast: self) in: ctx
]

{ #category : #typing }
AST >> sort [
	^(LibZ3 uniqueInstance getSort: ctx ast: self) ctx: ctx
]

{ #category : #modifiers }
AST >> substituteAll: fromArray with: toArray [
	| fromPointers toPointers resultPtr |
	toArray size = fromArray size ifFalse: [ self error ].
	fromPointers := self externalArrayFrom: fromArray.    
	toPointers   := self externalArrayFrom: toArray.
	resultPtr := LibZ3 uniqueInstance substitute: ctx ast: self
		numExprs: toArray size from: fromPointers to: toPointers.
	^AST wrap: resultPtr in: ctx
]

{ #category : #modifiers }
AST >> substituteVarsWith: toArray [
	| toPointers resultPtr |
	
	toPointers := self externalArrayFrom: toArray.
	resultPtr := LibZ3 uniqueInstance substituteVars: ctx ast: self
		numExprs: toArray size to: toPointers.
	^AST wrap: resultPtr in: ctx
]

{ #category : #'double dispatching' }
AST >> sumFromInteger:anInteger [
	"`anInteger` does not know how to sum itself with the receiver 
	 (a kind of AST). Coerce `anInteger` and retry.

	 St/X specific.
	"

	^ (self coerce: anInteger) + self

	"Modified (comment): / 09-09-2020 / 11:30:18 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #access }
AST >> sym [ 
	^self term sym
]

{ #category : #typing }
AST >> term [
	^self kindClass ctx: self ctx handle: self handle
]

{ #category : #access }
AST >> value [
	| thing |
	thing := self.
	thing isNumeral ifFalse: [ thing := thing simplify ]. "trying to be helpful"
	thing isNumeral ifFalse: [ ^self ].
	^Integer readFrom: thing getNumeralString
]

{ #category : #access }
AST >> variableNamed: aString [
	^self variables detect: [ :var | var sym = aString ] ifNone: [ nil ]
]

{ #category : #access }
AST >> variableNames [
	^self variables collect: [ :var | var sym ] 
]

{ #category : #access }
AST >> variables [
	"This terminology is extremely confusing.
	What we are talking here, are constants i.e. nullary function applications."
	^self term variables
]
