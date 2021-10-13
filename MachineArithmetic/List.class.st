Class {
	#name : #List,
	#superclass : #Z3DatatypeSort,
	#instVars : [
		'nilDecl',
		'isNilDecl',
		'consDecl',
		'isConsDecl',
		'headDecl',
		'tailDecl'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
List class >> name: aString sort: aSort [
	| instance nilDecl isNilDecl consDecl isConsDecl headDecl tailDecl |
	nilDecl := Array new: 1. isNilDecl := Array new: 1.
	consDecl := Array new: 1. isConsDecl := Array new: 1.
	headDecl := Array new: 1. tailDecl:= Array new: 1.
	instance := Z3 mk_list_sort: Z3Context current 
		_: aString toZ3Symbol 
		_: aSort
		_: nilDecl 
		_: isNilDecl
		_: consDecl
		_: isConsDecl 
		_: headDecl 
		_: tailDecl.
	instance := instance as: List.
	instance
		nilDecl: nilDecl first;
		consDecl: consDecl first;
		isNilDecl: isNilDecl first;
		isConsDecl: isConsDecl first;
		headDecl: headDecl first;
		tailDecl: tailDecl first.
	^instance 
		yourself 
	
]

{ #category : #'list operations' }
List >> car: car cdr: cdr [
	"Create a cons"
	^consDecl value: car value: cdr
]

{ #category : #accessing }
List >> consDecl [
	^ consDecl
]

{ #category : #accessing }
List >> consDecl: anObject [
	consDecl := anObject
]

{ #category : #'list operations' }
List >> head: aList [
	^headDecl value: aList
]

{ #category : #accessing }
List >> headDecl [
	^ headDecl
]

{ #category : #accessing }
List >> headDecl: anObject [
	headDecl := anObject
]

{ #category : #'list operations' }
List >> isCons: aList [
	^isConsDecl value: aList
]

{ #category : #accessing }
List >> isConsDecl [
	^ isConsDecl
]

{ #category : #accessing }
List >> isConsDecl: anObject [
	isConsDecl := anObject
]

{ #category : #'list operations' }
List >> isNil: aList [
	^isNilDecl value: aList
]

{ #category : #accessing }
List >> isNilDecl [
	^ isNilDecl
]

{ #category : #accessing }
List >> isNilDecl: anObject [
	isNilDecl := anObject
]

{ #category : #accessing }
List >> isNillDecl [
	^ isNilDecl
]

{ #category : #'list operations' }
List >> nil [
	"Answer the nil of the receiver sort"
	^nilDecl value
]

{ #category : #accessing }
List >> nilDecl [
	^ nilDecl
]

{ #category : #accessing }
List >> nilDecl: anObject [
	nilDecl := anObject
]

{ #category : #'list operations' }
List >> tail: aList [
	^tailDecl value: aList
]

{ #category : #accessing }
List >> tailDecl [
	^ tailDecl
]

{ #category : #accessing }
List >> tailDecl: anObject [
	tailDecl := anObject
]
