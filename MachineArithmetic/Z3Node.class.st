Class {
	#name : #Z3Node,
	#superclass : #Z3AST,
	#instVars : [
		'kind',
		'sort'
	],
	#pools : [
		'Z3SortKind'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #comparing }
Z3Node >> = another [
	^ [ super = (self coerce: another) ] on: Error do: [ false ]

]

{ #category : #adapting }
Z3Node >> adaptToInteger: x andSend: selector [
	"Pharo specific"
	^(self coerce: x) perform: selector with: self

]

{ #category : #adapting }
Z3Node >> adaptToNumber: x andSend: selector [
	"Pharo specific"
	self shouldBeImplemented.

]

{ #category : #adapting }
Z3Node >> beLikeMe: value [
	"Convert and return value to value of receiver's sort"
	self subclassResponsibility 
]

{ #category : #adapting }
Z3Node >> coerce: value [
	"Convert value to be of the same sort as receiver and return it"
	
	(value isAST and:[self sort = value sort]) ifTrue:[ ^ value ].
	^self beLikeMe: value.

]

{ #category : #'double dispatching' }
Z3Node >> differenceFromInteger:anInteger [
	"`anInteger` does not know how to subtract the receiver 
	 (a kind of AST). Coerce `anInteger` and retry.

	 St/X specific.
	"

	^ (self coerce: anInteger) - self

	"Modified: / 09-09-2020 / 11:28:43 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #access }
Z3Node >> elementOfModel: aZ3Model [
	| funcDecl |
	self term isConstant ifFalse: [ self shouldBeImplemented ].
	^aZ3Model getInterp: self term funcDecl 
	
	
]

{ #category : #operations }
Z3Node >> eq: rhs [
	^Z3 mk_eq: ctx _: self _: (self coerce: rhs)

]

{ #category : #'double dispatching' }
Z3Node >> equalFromInteger:anInteger [
	"`anInteger` does not know how to compare with the receiver 
	 (a kind of AST). Coerce `anInteger` and retry.

	 St/X specific.
	"

	^ (self coerce: anInteger) = self

	"Modified (comment): / 09-09-2020 / 11:31:31 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #quantifiers }
Z3Node >> exists: vars [
	| ffiVars |
	(vars isKindOf: Z3AST) ifTrue: [ ^self exists: (Array with: vars) ].
	ffiVars := self externalArrayFrom: vars.
	^Bool
		wrap: (LibZ3 uniqueInstance mkExistsConst: self ctx numBound: vars size bound: ffiVars body: self)
		in: ctx

]

{ #category : #quantifiers }
Z3Node >> forall: vars [
	| ffiVars |
	(vars isKindOf: Z3AST) ifTrue: [ ^self forall: (Array with: vars) ].
	ffiVars := self externalArrayFrom: vars.
	^Bool
		wrap: (LibZ3 uniqueInstance mkForAllConst: self ctx numBound: vars size bound: ffiVars body: self)
		in: ctx

]

{ #category : #access }
Z3Node >> getNumeralString [
	self assert: self isNumeral.
	^ Z3 get_numeral_string: ctx _: self.

]

{ #category : #'term rewriting' }
Z3Node >> inEnvironment: aDictionary [
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
Z3Node >> inThisEnvironment [
	| senderContext senderEnvironment |
	senderContext := thisContext sender.
	senderEnvironment := Dictionary new: senderContext size + 1"self".
	senderContext tempNames withIndexDo:[:n :i |
		senderEnvironment at: n put: (senderContext at: i)
	].
	senderEnvironment at: 'self' put: senderContext receiver.
	^ self inEnvironment: senderEnvironment
]

{ #category : #initialization }
Z3Node >> initializeWithAddress: anExternalAddress context: aZ3Context [
	self error: 'Should not be used, use #initializeWithAddress:context:kind:sort: instead'

]

{ #category : #initialization }
Z3Node >> initializeWithAddress: anExternalAddress context: aZ3Context kind: kindArg sort: aZ3Sort [
	super initializeWithAddress: anExternalAddress context: aZ3Context.
	kind := kindArg.
	sort := aZ3Sort.

]

{ #category : #accessing }
Z3Node >> kind [
	self assert: kind notNil.
	^ kind

]

{ #category : #'double dispatching' }
Z3Node >> lessFromInteger:anInteger [
	"`anInteger` does not know how to compare with the receiver 
	 (a kind of AST). Coerce `anInteger` and retry.

	 St/X specific.
	"

	^ (self coerce: anInteger) < self

	"Modified: / 09-09-2020 / 11:31:19 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #'double dispatching' }
Z3Node >> productFromInteger:anInteger [
	"`anInteger` does not know how to multiply itself with the receiver 
	 (a kind of AST). Coerce `anInteger` and retry.

	 St/X specific.
	"

	^ (self coerce: anInteger) * self

	"Modified: / 09-09-2020 / 11:27:27 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #operations }
Z3Node >> simplify [
	^ Z3 simplify: ctx _: self

]

{ #category : #accessing }
Z3Node >> sort [
	self assert: sort notNil.
	^ sort

]

{ #category : #modifiers }
Z3Node >> substituteAll: fromArray with: toArray [
	| fromPointers toPointers resultPtr |
	toArray size = fromArray size ifFalse: [ self error ].
	fromPointers := self externalArrayFrom: fromArray.    
	toPointers   := self externalArrayFrom: toArray.
	resultPtr := LibZ3 uniqueInstance substitute: ctx ast: self
		numExprs: toArray size from: fromPointers to: toPointers.
	^Z3AST wrap: resultPtr in: ctx

]

{ #category : #modifiers }
Z3Node >> substituteVarsWith: toArray [
	^ Z3 substitute_vars: ctx _: self _: toArray size _: toArray

]

{ #category : #'double dispatching' }
Z3Node >> sumFromInteger:anInteger [
	"`anInteger` does not know how to sum itself with the receiver 
	 (a kind of AST). Coerce `anInteger` and retry.

	 St/X specific.
	"

	^ (self coerce: anInteger) + self

	"Modified (comment): / 09-09-2020 / 11:30:18 / Jan Vrany <jan.vrany@labware.com>"
]

{ #category : #access }
Z3Node >> sym [ 
	^self term sym
]

{ #category : #access }
Z3Node >> value [
	| thing |
	thing := self.
	thing isNumeral ifFalse: [ thing := thing simplify ]. "trying to be helpful"
	thing isNumeral ifFalse: [ ^self ].
	^Integer readFrom: thing getNumeralString
]

{ #category : #access }
Z3Node >> variableNamed: aString [
	^self variables detect: [ :var | var sym = aString ] ifNone: [ nil ]
]

{ #category : #access }
Z3Node >> variableNames [
	^self variables collect: [ :var | var sym ] 
]

{ #category : #access }
Z3Node >> variables [
	"This terminology is extremely confusing.
	What we are talking here, are constants i.e. nullary function applications."
	^self term variables
]
