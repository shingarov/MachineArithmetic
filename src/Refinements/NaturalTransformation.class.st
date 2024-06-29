Class {
	#name : #NaturalTransformation,
	#superclass : #Object,
	#instVars : [
		'name',
		'components',
		'preSort'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
NaturalTransformation class >> name: α preSort: pre [
	^self basicNew
		name: α;
		components: (Set new);
		preSort: pre;
		yourself
]

{ #category : #gathering }
NaturalTransformation >> addComponent: aFFunc [
	self isFrozen ifTrue: [ 
		(components includes: aFFunc uncurry) 	ifFalse: [ self error ].
		^self ].
	self components add: aFFunc
]

{ #category : #'as yet unclassified' }
NaturalTransformation >> componentNames [
	^self components collectWithIndex: [ :_ :j | name instNumber: j ]
]

{ #category : #accessing }
NaturalTransformation >> components [
	^ components
]

{ #category : #accessing }
NaturalTransformation >> components: anObject [
	components := anObject
]

{ #category : #gathering }
NaturalTransformation >> freeze [
	"Indicate that all components have been gathered,
	 so no further addition is possible."
	components := components asArray collect: #uncurry
]

{ #category : #'SMT monomorphisation' }
NaturalTransformation >> from: D to: C [
	| smtD smtC idx f |
	smtD := D collect: #z3sort.
	smtC := C z3sort.
	idx := components detectIndex: [ :αc |
		| sig |
		sig := αc uncurriedZ3sig.
		sig key = smtD and: [ sig value = smtC ]].
	f := name instNumber: idx.
	^f functionFrom: smtD to: smtC
]

{ #category : #'as yet unclassified' }
NaturalTransformation >> functionSort [
	^#MARK_NOT_NIL "FIXME"
]

{ #category : #GT }
NaturalTransformation >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 10>
	components isNil ifTrue: [ ^nil ].
	^ composite fastList
		title: 'Components';
		display: [ components asOrderedCollection ];
		beSingle;
		format: [ :each | GTObjectPrinter asTruncatedTextFrom: each ]
]

{ #category : #'as yet unclassified' }
NaturalTransformation >> hasComponent: functionName [ 
	^self componentNames includes: functionName 
]

{ #category : #gathering }
NaturalTransformation >> instantiate [
	^preSort instantiate
]

{ #category : #gathering }
NaturalTransformation >> isFrozen [
	^components isArray
]

{ #category : #evaluating }
NaturalTransformation >> mkConst: aString [
	aString = name ifFalse: [ self error ].
	^self
]

{ #category : #accessing }
NaturalTransformation >> name [
	^ name
]

{ #category : #accessing }
NaturalTransformation >> name: anObject [
	name := anObject
]

{ #category : #accessing }
NaturalTransformation >> preSort [
	^ preSort
]

{ #category : #accessing }
NaturalTransformation >> preSort: anObject [
	preSort := anObject
]

{ #category : #printing }
NaturalTransformation >> printOn: aStream [
	aStream nextPutAll: 'NaturalTransformation '.
	aStream nextPutAll: name.
	aStream nextPutAll: '('.
	self components size printOn: aStream.
	aStream nextPutAll: ' components)'.
]

{ #category : #evaluating }
NaturalTransformation >> valueWithArguments: args [
	| D thisComponent C f |
	D := args collect: #sort.
	thisComponent := components detect: [ :α | α dom = D ]. "just to get C"
	C := thisComponent cod.
	f := self from: D to: C.
	^f valueWithArguments: args
]
