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

{ #category : #'double dispatching' }
Z3Node >> equalFromInteger:anInteger [
	"`anInteger` does not know how to compare with the receiver 
	 (a kind of AST). Coerce `anInteger` and retry.

	 St/X specific.
	"

	^ (self coerce: anInteger) = self

	"Modified (comment): / 09-09-2020 / 11:31:31 / Jan Vrany <jan.vrany@labware.com>"
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

{ #category : #accessing }
Z3Node >> sort [
	self assert: sort notNil.
	^ sort

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
