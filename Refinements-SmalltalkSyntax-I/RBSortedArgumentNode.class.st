Class {
	#name : #RBSortedArgumentNode,
	#superclass : #RBArgumentNode,
	#instVars : [
		'sort',
		'reft'
	],
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #'instance creation' }
RBSortedArgumentNode class >> named: v sort: s reft: r [
	^(self named: v)
		sort: s;
		reft: r;
		yourself
]

{ #category : #quantification }
RBSortedArgumentNode >> forceCorrectClassOf: aBlockNode [
	^aBlockNode as: RBQuantificationBlockNode 
]

{ #category : #accessing }
RBSortedArgumentNode >> parent: aRBProgramNode [ 
	parent := aRBProgramNode.
	sort parent: aRBProgramNode.
	reft isNil ifFalse: [ reft parent: aRBProgramNode ]
]

{ #category : #accessing }
RBSortedArgumentNode >> reft [
	^ reft
]

{ #category : #accessing }
RBSortedArgumentNode >> reft: anObject [
	reft := anObject
]

{ #category : #accessing }
RBSortedArgumentNode >> sort [
	^ sort
]

{ #category : #accessing }
RBSortedArgumentNode >> sort: anObject [
	sort := anObject
]
