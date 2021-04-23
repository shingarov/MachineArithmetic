Class {
	#name : #McCarthyArray,
	#superclass : #Z3AST,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
McCarthyArray class >> name: aString domain: d range: r [
	^d --> r mkConst: aString 
]

{ #category : #printing }
McCarthyArray class >> printSort: ty on: aStream [
	aStream nextPutAll: ty astToString 
]

{ #category : #enumerating }
McCarthyArray >> arraySelect: i [
	^Z3AST wrap: (LibZ3 uniqueInstance mkSelect: ctx a: self i: i) in: ctx

]

{ #category : #enumerating }
McCarthyArray >> arrayStore: i put: v [
	^Z3AST wrap: (LibZ3 uniqueInstance mkStore: ctx a: self i: i v: v) in: ctx

]
