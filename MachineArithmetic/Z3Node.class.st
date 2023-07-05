Class {
	#name : #Z3Node,
	#superclass : #Z3AST,
	#instVars : [
		'kind',
		'sort'
	],
	#pools : [
		'Z3ASTKind',
		'Z3SortKind'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #comparing }
Z3Node >> = another [
	^ [ super = (self coerce: another) ] on: Error do: [ false ]
]

{ #category : #comparing }
Z3Node >> === rhs [
	^ self eq: rhs
]

{ #category : #adapting }
Z3Node >> adaptToInteger: receiver andSend: selector [
	"Pharo specific"
	^(self coerce: receiver) perform: selector with: self

]

{ #category : #accessing }
Z3Node >> argAt: index [
	"Answer the i-th argument.
	 Indexing is 1-based (i.e. Smalltalk convention)."

	(self isApp not or:[index > self arity]) ifTrue: [ self errorSubscriptBounds: index ].
	^ Z3 get_app_arg: ctx _: self _: index - 1.

]

{ #category : #accessing }
Z3Node >> args [
	| arity |
	arity := self arity.
	arity = 0 ifTrue: [ ^#() ].
	^(1 to: arity) collect: [ :i | self argAt: i ]   

]

{ #category : #enumerating }
Z3Node >> argsDo: aBlock [
	1 to: self arity do: [:i | aBlock value: (self argAt: i) ]

]

{ #category : #accessing }
Z3Node >> arity [
	"Return the number of argument of an application.
	 A function of zero arguments is called a constant."
	self isApp ifTrue: [
		^ Z3 get_app_num_args: ctx _: self
	].
	^ 0

]

{ #category : #GT }
Z3Node >> childrenForInspector [
	self isApp ifTrue: [^self args].
	^#()
]

{ #category : #adapting }
Z3Node >> coerce: value [
	"Convert value to be of the same sort as receiver and return it"
	
	(value isAST and:[self sort == value sort]) ifTrue:[ ^ value ].
	^self sort cast: value.
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

{ #category : #accessing }
Z3Node >> elementOfModel: aZ3Model [
	self isConstant ifFalse: [ self shouldBeImplemented ].
	^aZ3Model getInterp: self funcDecl 

]

{ #category : #operations }
Z3Node >> eq: rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_eq: ctx _: self _: rhs.
	].
	^self retry: #eq: coercing: rhs
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
	(vars isKindOf: Z3AST) ifTrue: [ ^self exists: (Array with: vars) ].

	^ Z3 mk_exists_const: ctx _: 0 _: vars size _: vars _: 0 _: #() _: self

]

{ #category : #quantifiers }
Z3Node >> forall: vars [
	(vars isKindOf: Z3AST) ifTrue: [ ^self forall: (Array with: vars) ].
	^ Z3 mk_forall_const: ctx _: 0 _: vars size _: vars _: 0 _: #() _: self

]

{ #category : #accessing }
Z3Node >> funcDecl [
	self assert: self isApp.
	^ Z3 get_app_decl: ctx _: self.

]

{ #category : #accessing }
Z3Node >> functorName [
	self assert: self isApp.
	^ self funcDecl name asString

]

{ #category : #accessing }
Z3Node >> getNumeralString [
	self assert: self isNumeral.
	^ Z3 get_numeral_string: ctx _: self.

]

{ #category : #GT }
Z3Node >> gtInspectorTreeIn: composite [
	<gtInspectorPresentationOrder: 50>
	^ composite fastTree
		title: 'AST Tree';
		children: #childrenForInspector;
		display: {self}
]

{ #category : #'term rewriting' }
Z3Node >> inEnvironment: aDictionary [
	| from to |
	aDictionary isEmpty ifTrue: [ ^self ].

	from := OrderedCollection new: aDictionary size.
	to := OrderedCollection new: aDictionary size.

	self variablesDo: [ :var |
		| val |

		val := aDictionary at: var 
							 ifAbsent:[aDictionary at: var functorName ifAbsent: nil].
		val isNil ifFalse:[
			from add: var.
			to   add:(var coerce: val).
		]
	].
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

{ #category : #testing }
Z3Node >> isConstant [
	^ self isApp and: [self arity == 0]
]

{ #category : #testing }
Z3Node >> isConstantNamed: v [ 
	^self isNamedConstant
			and: [ self functorName = v ]
]

{ #category : #testing }
Z3Node >> isLeaf [
	^ self isConstant or: [ self isNumeral or: [ self isVar ]]
]

{ #category : #testing }
Z3Node >> isLikeMe: object [
	^ object isNode and:[ self sort = object sort ]
	
	"
	1 toInt isLikeMe: 2 toReal
	"
]

{ #category : #testing }
Z3Node >> isNamedConstant [
	^self isApp and: [self arity == 0]
]

{ #category : #testing }
Z3Node >> isNode [
	^true
]

{ #category : #testing }
Z3Node >> isVar [
	"Return true if the receiver is variable.
	 Z3 uses de-Bruijn indices for representing bound variables in quantifiers."
	^self kind = VAR_AST
]

{ #category : #accessing }
Z3Node >> justVariables [
	^self variables
		reject: [ :v | v functorName = 'true' or: [ v functorName = 'false' ] ]
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

{ #category : #adapting }
Z3Node >> retry: selector coercing: rhs [
	^self subclassResponsibility
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

{ #category : #'term rewriting' }
Z3Node >> substitute: x with: y [
	^self substituteAll: { x. } with: { y. }
]

{ #category : #'term rewriting' }
Z3Node >> substituteAll: fromArray with: toArray [
	self assert: fromArray size = toArray size.
	^ Z3 substitute: ctx _: self _: fromArray size _: fromArray _: toArray.

]

{ #category : #'term rewriting' }
Z3Node >> substituteVars: from with: to [
	^self substituteVarsWith: { from . to }
]

{ #category : #'term rewriting' }
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

{ #category : #accessing }
Z3Node >> sym [
	self isApp ifFalse: [ 
		self error: 'Only valid for applications'.
		^ nil.
	].
	self isConstant ifFalse: [ 
		| simplified |

		simplified := self simplify.
		simplified isConstant ifFalse: [
			self error: 'Cannot be simplified to constant'.
			^ nil
		].
		^ simplified functorName
	].
	^ self functorName

]

{ #category : #'as yet unclassified' }
Z3Node >> toSingletonZ3Set [
	^Z3Set with: self
]

{ #category : #'as yet unclassified' }
Z3Node >> toZ3Sort: s [ 
	self sort == s ifFalse: [ Incompatible signal ].
	^self
]

{ #category : #accessing }
Z3Node >> value [
	| thing |
	thing := self.
	thing isNumeral ifFalse: [ thing := thing simplify ]. "trying to be helpful"
	thing isNumeral ifFalse: [ ^self ].
	^Integer readFrom: thing getNumeralString
]

{ #category : #accessing }
Z3Node >> variableNamed: aString [
	self variablesDo: [:each | each functorName = aString ifTrue: [ ^ each ] ].
	^ nil

]

{ #category : #accessing }
Z3Node >> variableNames [
	^Set newFrom: (self variables collect: [ :var | var functorName ] )

]

{ #category : #accessing }
Z3Node >> variables [
	"This terminology is extremely confusing.
	 What we are talking here, are constants i.e. nullary function applications."

	| variables |

	variables := IdentitySet new.
	self variablesDo: [ :each | variables add: each ].
	^ variables

]

{ #category : #enumerating }
Z3Node >> variablesDo: aBlock [
	self isApp ifTrue: [
		| arity |

		arity := self arity.
		arity == 0 ifTrue: [ 
			aBlock value: self 
		] ifFalse: [
			1 to: arity do: [ :i | (self argAt: i) variablesDo: aBlock ]
		].
	]

]

{ #category : #comparing }
Z3Node >> ~== rhs [
	^ (self === rhs) not
]
