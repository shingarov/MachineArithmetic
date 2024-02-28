Class {
	#name : #EBin,
	#superclass : #Expr,
	#instVars : [
		'bop',
		'left',
		'right'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EBin class >> bop: bop left: left right: right [
	^self basicNew
		bop: bop;
		left: left;
		right: right;
		yourself
]

{ #category : #visiting }
EBin >> accept: aVisitor [
	^self class
		bop: bop
		left: (left accept: aVisitor)
		right: (right accept: aVisitor)
]

{ #category : #accessing }
EBin >> bop [
	^ bop
]

{ #category : #accessing }
EBin >> bop: anObject [
	bop := anObject
]

{ #category : #'term rewriting' }
EBin >> evaluateIn: anEvalEnv [
	^(left evaluateIn: anEvalEnv)
		perform: bop class smalltalkSelector
		with: (right evaluateIn: anEvalEnv)
]

{ #category : #accessing }
EBin >> left [
	^ left
]

{ #category : #accessing }
EBin >> left: anObject [
	left := anObject
]

{ #category : #accessing }
EBin >> right [
	^ right
]

{ #category : #accessing }
EBin >> right: anObject [
	right := anObject
]
