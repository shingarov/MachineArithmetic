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
Z3Node >> sort [
	self assert: sort notNil.
	^ sort

]
