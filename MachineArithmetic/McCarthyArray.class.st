Class {
	#name : #McCarthyArray,
	#superclass : #Z3Node,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
McCarthyArray class >> name: aString domain: d range: r [
	^ d-->r mkConst: aString
]

{ #category : #enumerating }
McCarthyArray >> arraySelect: i [
	^ Z3 mk_select: ctx _: self _: i

]

{ #category : #enumerating }
McCarthyArray >> arrayStore: i put: v [
	^ Z3 mk_store: ctx _: self _: i _: v

]
